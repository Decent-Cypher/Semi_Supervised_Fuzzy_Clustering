function V = init_cluster_prototypes_modified_fcm (X, k, label)
    num_features = columns (X);
    V = rand(k, num_features);
    for i = 1:k
        X_generator = X(label==i, :);
        if (size(X_generator, 1) <= 2)
            X_generator = X;
        endif
        coefficients = rand(1, size(X_generator, 1));
        coefficients /= sum(coefficients);
        V(i, :) = coefficients * X_generator;
    endfor
endfunction
