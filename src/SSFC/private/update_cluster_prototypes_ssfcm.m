function V = update_cluster_prototypes (U, X, k, U_pre)
  delta_U_m = (abs(U - U_pre)).^m;
  V = delta_U_m * X;
  sum_delta_U_m = sum (delta_U_m');
  if (prod (sum_delta_U_m) == 0)
    error ("division by 0 in function update_cluster_prototypes_ssfcm\n");
  endif
  for i = 1 : k
    V(i, :) /= sum_delta_U_m(i);
  endfor
endfunction