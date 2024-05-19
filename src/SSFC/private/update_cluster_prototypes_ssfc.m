function V = update_cluster_prototypes_ssfc (delta_U_2, X, k, U, lambda)
U_temp = U .* U + lambda*delta_U_2;
  V = U_temp * X;
  sum_delta_check = sum (U_temp');
  if (prod (sum_delta_check) == 0)
    error ("division by 0 in function update_cluster_prototypes_ssfcm\n");
  endif
  for i = 1 : k
    V(i, :) /= sum_delta_check(i);
  endfor
endfunction