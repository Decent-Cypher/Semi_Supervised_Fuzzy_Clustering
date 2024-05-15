function obj_fcn = compute_cluster_obj_fcn_ssfc (delta_U_2, sqr_dist, U, lambda)

  obj_fcn = sum (sum ((U.*U + lambda * delta_U_2) .* sqr_dist));

endfunction