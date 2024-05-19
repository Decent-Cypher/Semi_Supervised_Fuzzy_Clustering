function U = update_cluster_membership_modified_fcm(V, X, m, k, n, sqr_dist)
  U = zeros(k, n);
  if (min(min(sqr_dist)) > 0)
    exponent = 1.0 / (m-1);
    for i = 1:k
      for j = 1:n
        summation = 0.0;
        for l = 1:k
          summation += (sqr_dist(i, j) / sqr_dist(l, j))^exponent;
        endfor
        if (summation != 0)
          U(i, j) = 1.0 / summation;
        else
          error("division by 0 in update_cluster_membership_modified_fcm\n");
        endif
      endfor
    endfor

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