## Considering the membership degree and the structure of datasets, Xie and Beni proposed the XB index to measure the overall average compactness and separateness, and the smaller its value, the better the partition result

function XB = xie_beni(data_matrix, cluster_centers, partition_matrix, m)
    sqr_dist_XV = square_distance_matrix(data_matrix, cluster_centers);
    sqr_dist_VV = square_distance_matrix(cluster_centers, cluster_centers);
    U_m = partition_matrix .^ m;
    J_m = sum(sum(U_m .* sqr_dist_XV));
    N = size(data_matrix, 1);
    k = size(cluster_centers, 1);
    sqr_dist_VV(1:(k+1):end) = Inf;
    XB = J_m / (N * min(min(sqr_dist_VV)));
endfunction

function sqr_dist = square_distance_matrix (X, V)
  k = rows (V);
  n = rows (X);
  sqr_dist = zeros (k, n);
  for i = 1 : k
    Vi = V(i, :);
    for j = 1 : n
      Vi_to_Xj = X(j, :) - Vi;
      sqr_dist(i, j) = sum (Vi_to_Xj .* Vi_to_Xj);
    endfor
  endfor
endfunction


