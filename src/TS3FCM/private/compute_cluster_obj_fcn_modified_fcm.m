function obj_fcn = compute_cluster_obj_fcn_modified_fcm(U_2, sqr_dist, weights)
    U_2 = U_2 .* weights';
    obj_fcn = sum (sum (U_2 .* sqr_dist));
endfunction