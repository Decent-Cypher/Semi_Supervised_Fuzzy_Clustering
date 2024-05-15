function obj_fcn = compute_cluster_obj_fcn_ssfcm (delta_U_m, sqr_dist)

  obj_fcn = sum (sum (delta_U_m .* sqr_dist));

endfunction