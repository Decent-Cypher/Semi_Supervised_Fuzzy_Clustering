function U = update_cluster_membership_ssfc(V, X, lambda, k, n, sqr_dist, U_pre)
  U = zeros(k, n);
  if (min(min(sqr_dist)) > 0)
    ## Normal update using FCM algorithm
    for i = 1:k
      for j = 1:n
        summation = 0.0;
        for l = 1:k
          summation += (sqr_dist(i, j) / sqr_dist(l, j));
        endfor
        if (summation != 0)
          U(i, j) = 1.0 / summation;
        else
          error("division by 0 in update_cluster_membership_ssfcm\n");
        endif
      endfor
    endfor
    ## Update according to the Semi-supervised fuzzy clustering algorithm
    U = (1/(1+lambda)) * ((1+lambda-lambda*sum(U_pre))./summation - lambda*U_pre);

  else
    num_zeros = 0;
    for i = 1 : k
      for j = 1 : nargin
        if (sqr_dist(i, j) == 0)
          num_zeros++;
          U(i, j) = 1.0;
        endif
      endfor
    endfor
    U = U / num_zeros;
  endif
endfunction