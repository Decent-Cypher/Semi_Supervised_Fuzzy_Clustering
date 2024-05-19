% This is a helper function for the modified version of the FCM algorithm
% It calculates and returns the matrix [n_1k, n_2k, n_3k]
% where n_1k is the number of unlabeled data neighbors of X_k, n_2k is the number of neighbors with the same label to X_k and n_3k is the number of neighbors with different label to X_k
% The return value is in the form of an N x 3 matrix where the columns corresponds to n_1, n_2 and n_3, respectively

## label is a vector of size N x 1, where the element is the label (1->l) associated with the data point or -1 for no label
## sqr_dist is the distance matrix precalculated from X, the original data, size N x N
## R is the radius used to define the neighbors
function neighbors_data = get_neighbors_data(label, sqr_dist, R)
    % Get the number of data points
    n = length(label);
    
    % Initialize the output vector
    n_1 = zeros(n, 1);
    n_2 = zeros(n, 1);
    n_3 = zeros(n, 1);
    
    % Loop over each data point
    for k = 1:n
        if label(k) != -1
            % Logical vector indicating which points are within distance R from point k
            neighbors = (sqr_dist(:, k) < R);
            % Exclude the point itself
            neighbors(k) = false;
            % Logical vector indicating which points have the same label as point k
            sameLabel = (label == label(k));
            unlabeled = (label == -1);
            
            % Count how many points are close and have the same label
            n_2(k) = sum(neighbors & sameLabel);
            % Count how many points are close and are unlabeled
            n_1(k) = sum(neighbors & unlabeled);
            % Count how many points are close and have different label
            n_3(k) = sum(neighbors & (~unlabeled) & (~sameLabel));
        else
            n_1(k) = -1;
            n_2(k) = -1;
            n_3(k) = -1;
        endif
    endfor
    neighbors_data = [n_1, n_2, n_3];
endfunction