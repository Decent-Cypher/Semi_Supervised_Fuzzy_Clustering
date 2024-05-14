
  % X: Data matrix (each row represents a data point)
  % k: Number of clusters
  % U_pre: Predefined membership value matrix (each column represents a data point and each row represents a cluster centers)
  % m: Fuzziness parameter
  % max_iter: Maximum number of iterations
  % tol: Tolerance for convergence
addpath('private');
function [cluster_centers, U, obj_func_history] = ssfcm(X, k, U_pre, options = [2.0, 100, 1e-5, 1])

  ## If ssfcm was called with an incorrect number of arguments or
  ## if the arguments do not have the correct type, print an error
  ## and halt.

  if ((nargin != 3) && (nargin != 4))
    error ("ssfcm requires 3 or 4 arguments\n");
  elseif (!is_real_matrix (X))
    error ("ssfcm's first argument must be matrix of real numbers\n");
  elseif (!(is_int (k) && (k > 1)))
    error ("ssfcm's second argument must be an integer greater than 1\n");
  elseif (!(is_real_matrix(U_pre) && all(sum(matrix) <= 1) && size(U_pre, 1) == k))
    error ("ssfcm's third argument must be a matrix of real numbers where the sum of each column is <= 1 and the number of rows is k (the number of clusters\n");
  elseif (!(isreal (options) && isvector (options)))
    error ("ssfcm's fourth argument must be a vector of real numbers\n");
  endif

  default_options = [2.0, 100, 1e-5, 1];
  for i = 1:4
    if ((length(options) < i) || isna(options(i)) || isnan(options(i)))
      options(i) = default_options(i);
    endif
  endfor

  m = options(1);
  max_iterations = options(2);
  epsilon = options(3);
  display_intermediate_results = options(4);

  ## Call a private function to compute the output_precision
  [cluster_centers, U, obj_func_history] = ssfcm_private(X, k, U_pre, m, max_iterations, epsilon, display_intermediate_results);
endfunction

function [V, U, obj_func_history] = ssfcm_private(X, k, U_pre, m, max_iterations, epsilon, display_intermediate_results)
  # Initialize the prototypes and the calculation.
  V = init_cluster_prototypes(X, k);
  obj_func_history = zeros(max_iterations);
  convergence_criterion = epsilon + 1;
  iteration = 0;

  # Calculate a few numbers here to reduce redundant computation
  k = rows(V);
  n = rows(X);
  sqr_dist = square_distance_matrix(X, V);

  ## Loop until the objective function is within tolerance or the
  ## maximum number of iterations has been reached
  while (convergence_criterion > epsilon && ++iteration <= max_iterations)
    V_previous = V;
    U = update_cluster_membership_ssfcm(V, X, m, k, n, sqr_dist, U_pre);

    delta_U_m = (abs(U - U_pre)).^m;
    V = update_cluster_membership_ssfcm(delta_U_m, X, k, U_pre);
    sqr_dist = square_distance_matrix(X, V);
    obj_func_history(iteration) = compute_cluster_obj_fcn_ssfcm(delta_U_m, sqr_dist);
    if (display_intermediate_results)
      printf("Iteration count = %d, Objective fcn = %8.6f\n", iteration, obj_func_history(iteration));
    endif
    convergence_criterion = compute_cluster_convergence(V, V_previous);
  endwhile

  ## Remove extraneous entries from the tail of the objective function history
  if (convergence_criterion <= epsilon)
    obj_func_history = obj_func_history(1:iteration);
  endif
endfunction








