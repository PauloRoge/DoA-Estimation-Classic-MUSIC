function [musicpseudospectrum, eigenvalues] = music(Y, M, theta, snapshots, delta, lambda, method)
    
    R = (Y * Y') / snapshots; % matriz de covariancia media

    % decomposição em autovalores e autovetores
    [eigenvectors, eigenvalues] = eig(R);
    eigenvalues_sorted = sort(diag(eigenvalues), 'descend'); % ordenar em ordem decrescente
    eigenvalues_sorted = eigenvalues_sorted / sum(eigenvalues_sorted); % normalização dos autovalores
    
    % escolher o metodo de estimação do numero de fontes
    switch lower(method)
        case 'aic'
            aic = aic_estimation(M, eigenvalues_sorted, snapshots);
            [~, estimated_sources] = min(aic);
            disp(['Número estimado de fontes (AIC) para M = ', num2str(M), ': ', num2str(estimated_sources)]);
        
        case 'gap'
            estimated_sources = gap_estimation(eigenvalues_sorted);
            disp(['Número estimado de fontes (GAP) para M = ', num2str(M), ': ', num2str(estimated_sources)]);
        
        case 'mdl'
            mdl = mdl_estimation(M, eigenvalues_sorted, snapshots);
            [~, estimated_sources] = min(mdl);
            disp(['Número estimado de fontes (MDL) para M = ', num2str(M), ': ', num2str(estimated_sources)]);

        otherwise
            error('Método inválido. Escolha entre "aic", "gap" ou "mdl".');
    end

    % selecionar autovetores do espaço de ruido
    [~, i] = sort(diag(eigenvalues), 'descend');
    eigenvectors = eigenvectors(:, i);
    Vn = eigenvectors(:, estimated_sources+1:end);

    % inicializar o pseudoespectro MUSIC
    Pmusic = zeros(size(theta));

    for i = 1:length(theta)
        a = responsearray(M, delta, lambda, theta(i));
        Pmusic(i) = 1 / (a' * (Vn * Vn') * a);
    end

    Pmusic = abs(Pmusic) / max(abs(Pmusic)); % normalizacao do pseudoespectro
    musicpseudospectrum = Pmusic;
    eigenvalues = eigenvalues_sorted;
end
