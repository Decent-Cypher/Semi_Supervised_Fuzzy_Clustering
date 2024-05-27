addpath('./TS3FCM');
addpath('./TS3FCM/private');
addpath('./TS3FCM/modified_FCM');
addpath('./validity_index');

## Testing on the Glass classification UCI dataset
% Read the data from the file
data = dlmread('../others/glass.data', ',');

% Separate the features into matrix X
X = data(:, 2:end-1);
% Separate the labels into vector label
label = data(:, end);
label(label==7) = 4;
label(randperm(size(label), size(label) - 35)) = -1;


sqr_dist = square_distance_matrix(X, X);
R = (max(max(sqr_dist)) - min(min(sqr_dist)))/20;
neighbors = get_neighbors_data(label, sqr_dist, R);

%% Testing of the modified version of FCM
%% [V, U, obj_func_history] = modified_fcm(X, 3, 2, label, 100, 1e-5, 1);

label(label==6) = -1;
[V, U, obj_func_history] = ts3fcm(X, 5, label, [2.0, 100, 1e-5, 0, 2.0]);

% Calculating validity indices for the result
disp("Partition coefficient: ");
disp(partition_coefficient(U));
disp("Partition entropy: ");
disp(partition_entropy(U));
disp("Modified partition coefficient: ");
disp(modified_PC(U));
disp("Xie - Beni index: ");
disp(xie_beni(X, V, U, 2));