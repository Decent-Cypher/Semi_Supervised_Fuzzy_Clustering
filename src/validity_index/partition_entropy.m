## The partition entropy (PE) measures the fuzzy degree of final divided clusters by means of the fuzzy partition matrix, and the smaller its value, the better the partition result
%% partition_matrix: A matrix of size k x N, where each column corresponds to the memberships of a data point to each cluster

function PC = partition_entropy(partition_matrix)
    if (!(ismatrix(partition_matrix) && isreal(partition_matrix) && all(partition_matrix(:) >= 0) && all(abs(sum(partition_matrix, 1) - 1) < 1e-5)))
        error("The input is not an appropriate fuzzy partition matrix");
    endif
    N = size(partition_matrix, 2);
    PC = -(1/N)*(sum(sum(partition_matrix .* log(partition_matrix))));
