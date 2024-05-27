
addpath('./TS3FCM');
addpath('./TS3FCM/private');
addpath('./TS3FCM/modified_FCM');
addpath('./validity_index');

## Testing on the Iris Flower dataset
%% Convert the original dataset into data for semi-supervised learning and testing
[X, label] = read_iris_data('../others/iris.data');
label(randperm(50, 47)) = -1;
label(randperm(50, 47) + 50) = -1;
label(randperm(50, 47) + 100) = -1;
dlmwrite('iris_semi_supervised.data', [X, label]);
data = dlmread('iris_semi_supervised.data');
X = data(:, 1:4);
label = data(:, 5);
labeled_indices = label != -1;
disp("The entries used as labeled data (Iris dataset) are: ");
disp(data(labeled_indices, :));

sqr_dist = square_distance_matrix(X, X);
R = (max(max(sqr_dist)) - min(min(sqr_dist)))/100; # 0.502
neighbors = get_neighbors_data(label, sqr_dist, R);

%% Testing of the modified version of FCM
%% [V, U, obj_func_history] = modified_fcm(X, 3, 2, label, 100, 1e-5, 1);

[V, U, obj_func_history] = ts3fcm(X, 3, label, [2.0, 100, 1e-5, 0, 2.0]);

% Calculating validity indices for the result
disp("Partition coefficient: ");
disp(partition_coefficient(U));
disp("Partition entropy: ");
disp(partition_entropy(U));
disp("Modified partition coefficient: ");
disp(modified_PC(U));
disp("Xie - Beni index: ");
disp(xie_beni(X, V, U, 2));