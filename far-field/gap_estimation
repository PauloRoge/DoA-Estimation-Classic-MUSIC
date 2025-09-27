function estimated_sources = gap_estimation(eigenvalues_sorted)
    % GAP de autovalores para estimar o número de fontes
    % eigenvalues_sorted: Vetor de autovalores ordenados em ordem decrescente

    % Calcular a razão entre autovalores consecutivos
    eigen_gap = eigenvalues_sorted(1:end-1) ./ eigenvalues_sorted(2:end);

    % Encontrar o índice do maior GAP
    [~, estimated_sources] = max(eigen_gap);

    % Ajustar para não exceder limites
    estimated_sources = min(estimated_sources, length(eigenvalues_sorted)-1);
    
end
