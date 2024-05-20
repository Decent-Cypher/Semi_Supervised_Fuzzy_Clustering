function U = defuzzificate(U, label, N)
    if ((size(U, 2) != size(label)) || (size(label) != N))
        error("The dimensions for the defuzzification function does not match");
    endif
    k = size(U, 1);
    for i = 1:N
        if (label(i) != -1)
            [max_membership, cluster_label] = max(U(:, i));
            if cluster_label != label(i)
                U(:, i) += max_membership/(2*(k-1));
                U(cluster_label, i) *= (2*k-2)/(4*k-2);
            endif
        endif
    endfor
