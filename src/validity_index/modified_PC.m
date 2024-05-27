## Because the value of PC merely depends on the membership degree u_ci, Dave proposed the modified PC index MPC, and the larger its value, the better the partition result
%% partition_matrix: A matrix of size k x N, where each column corresponds to the memberships of a data point to each cluster

function MPC = modified_PC(partition_matrix)
    PC = partition_coefficient(partition_matrix);
    c = size(partition_matrix, 1);
    MPC = (c*PC - 1) / (c-1);