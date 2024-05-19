function V = update_cluster_prototypes_modified_fcm(U_m, X, k, weights)
    U_m = U_m .* weights';
    V = U_m * X;
    sum_U_m = sum(U_m');
    if (prod(sum_U_m) == 0)
        error ("division by 0 in function update_cluster_prototypes_modified_fcm\n");
    endif
    for i = 1:k
        V(i, :) /= sum_U_m(i);
    endfor
endfunction