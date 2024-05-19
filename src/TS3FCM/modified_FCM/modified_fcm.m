% This is a helper function for the TS3FCM algorithm
% It runs a modified FCM algorithm for the labeled data only (and add weights for them)

## X is the dataset where each row corresponds to a data point and each column corresponds to a feature, size N x f
## k is the desired number of clusters
## label is a vector of size N x 1, where the element is the label (0->l) associated with the data point or -1 for no label



function [V, U, obj_func_history] = modified_fcm(X, k, m, label, max_iterations, epsilon, display_intermediate_results)
  addpath('TS3FCM/private');

  sqr_dist = square_distance_matrix(X, X);
  neighbors_data = get_neighbors_data(label, sqr_dist, (max(max(sqr_dist)) - min(min(sqr_dist)))/10);

  # Extract the labeled data to perform the FCM algorithm
  labeled_index = label != -1;
  X = X(labeled_index, :);
  label = label(labeled_index);
  neighbors_data = neighbors_data(labeled_index, :);
  weights = (neighbors_data(:, 1) + neighbors_data(:, 2))./(neighbors_data(:, 3)+1);

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
    U = update_cluster_membership_modified_fcm(V, X, m, k, n, sqr_dist);
    U_m = U .^ m;
    V = update_cluster_prototypes_modified_fcm(U_m, X, k, weights);
    sqr_dist = square_distance_matrix(X, V);
    obj_func_history(iteration) = compute_cluster_obj_fcn_modified_fcm(U_m, sqr_dist, weights);
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