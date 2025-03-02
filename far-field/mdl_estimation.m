function mdl_values = mdl_estimation(M, eigenvalues, snapshots)
    % MDL Estimation for Number of Sources
    % M: Number of antennas
    % eigenvalues: Sorted eigenvalues of the covariance matrix
    % snapshots: Number of snapshots (samples)

    % Número de candidatos a fontes
    k_values = 0:(M-1);
    
    % Inicializa o vetor MDL
    mdl_values = zeros(1, length(k_values));
    
    for k = k_values
        % Média geométrica dos autovalores de ruído
        if k < M
            geometric_mean = exp(sum(log(eigenvalues(k+1:M))) / (M - k));
        else
            geometric_mean = 0;
        end
        
        % Média aritmética dos autovalores de ruído
        arithmetic_mean = sum(eigenvalues(k+1:M)) / (M - k);
        
        % Cálculo do critério MDL
        if k < M
            mdl_values(k+1) = -(M - k) * snapshots * log(geometric_mean / arithmetic_mean) ...
                + 0.5 * k * (2 * M - k) * log(snapshots);
        else
            mdl_values(k+1) = Inf; % Evita erro para k = M
        end
    end
end
