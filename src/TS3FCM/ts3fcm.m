

function [V, U, obj_func_history] = ts3fcm(X, k, label, options = [2.0, 100, 1e-5, 1, 2.0])
    addpath('TS3FCM/modified_FCM');
    addpath('TS3FCM/private');
    addpath('SSFC');
    if ((nargin != 3) && (nargin != 4))
        error ("ts3fcm requires 2 or 3 arguments\n");
    elseif (!is_real_matrix (X))
        error ("ts3fcm's first argument must be matrix of real numbers\n");
    elseif (!(is_int (k) && (k > 1)))
        error ("ts3fcm's second argument must be an integer greater than 1\n");
    elseif (!(size(X, 1) == size(label, 1)) && (isvector(label)))
        error ("The size of the label vector for the ts3fcm must be the same as the number of rows in X");
    elseif (!(isreal (options) && isvector (options)))
        error ("ts3fcm's third argument must be a vector of real numbers\n");
    endif

    ## Assign options to the more readable variable names: m,
    ## max_iterations, epsilon, and display_intermediate_results.
    ## If options are missing or NaN (not a number), use the default
    ## values.

    default_options = [2.0, 100, 1e-5, 1, 2.0];

    for i = 1 : 5
        if ((length (options) < i) || isna (options(i)) || isnan (options(i)))
            options(i) = default_options(i);
        endif
    endfor

    m = options(1);
    max_iterations = options(2);
    epsilon = options(3);
    display_intermediate_results = options(4);
    lambda = options(5);
    n = size(X, 1);

    ## Phase 1 of the algorithm, apply the modified version of FCM to get the cluster_centers
    if (display_intermediate_results)
        disp("Phase 1 of TS3FCM: Running of the modified version of FCM");
    endif
    [V, U, obj_func_history] = modified_fcm(X, k, m, label, max_iterations, epsilon, display_intermediate_results);
    # if (display_intermediate_results)
    #     disp(V);
    #     disp(U);
    # endif

    ## Phase 2 of the algorithm, employ the FCM algorithm only once to get the membership values of both labeled and unlabeled data
    if (display_intermediate_results)
        disp("Phase 2 of TS3FCM: Performing one iteration of normal FCM to get the predefined membership");
    endif
    sqr_dist = square_distance_matrix(X, V);
    U_pre = update_cluster_membership_modified_fcm(V, X, m, k, n, sqr_dist);
    # if (display_intermediate_results)
    #     disp(V);
    #     disp(U_pre);
    # endif

    ## Phase 3 of the algorithm, utilize the semi supervised fuzzy clustering (SSFC) for the whole data, using lambda = 2
    if (display_intermediate_results)
        disp("Phase 3 of TS3FCM: Running of the SSFC on the predefined membership calculated by the previous phases");
    endif
    [V, U, obj_func_history] = ssfc(X, k, U_pre, [2.0, max_iterations, epsilon, display_intermediate_results]);


