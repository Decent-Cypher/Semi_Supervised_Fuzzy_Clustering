
addpath('./TS3FCM');
addpath('./TS3FCM/private');
addpath('./TS3FCM/modified_FCM');

%% Convert the original dataset into data for semi-supervised learning and testing
# [X, label] = read_iris_data('../others/iris.data');
# label(1:47) = -1;
# label(51:97) = -1;
# label(101:147) = -1;
# disp([X, label]);
# dlmwrite('iris_semi_supervised.data', [X, label]);

labeled_indices = label != -1;

data = dlmread('iris_semi_supervised.data');
X = data(:, 1:4);
label = data(:, 5);
disp("The entries used as labeled data are: ");
disp(data(labeled_indices, :));

sqr_dist = square_distance_matrix(X, X);
R = (max(max(sqr_dist)) - min(min(sqr_dist)))/100; # 0.502
neighbors = get_neighbors_data(label, sqr_dist, R);
disp("The neighbors data for the modified FCM is");
disp(neighbors(labeled_indices, :));

%% Testing of the modified version of FCM
## [V, U, obj_func_history] = modified_fcm(X, 3, 2, label, 100, 1e-5, 1);

[V, U, obj_func_history] = ts3fcm(X, 3, label, [2.0, 100, 1e-5, 0, 2.0]);
disp(V);
disp(U);