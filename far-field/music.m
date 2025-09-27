function [musicpseudospectrum, eigenval] = music(Y, M, ...
    theta, snapshots, delta, lambda, method)
    
    R = (Y * Y') / snapshots; % matriz de covariancia media

    % decomposição em autovalores e autovetores
    [eigenvec, eigenval] = eig(R);
    eigenval_sorted = sort(diag(eigenval), 'descend'); 
    eigenval_sorted = eigenval_sorted / sum(eigenval_sorted); 
    
    % escolher o metodo de estimação do numero de fontes
    switch lower(method)
        case 'aic'
            aic = aic_estimation(M, eigenval_sorted, snapshots);
            [~, estimated_sources] = min(aic);
            disp(['Número estimado de fontes (AIC) para M = ', ...
                num2str(M), ': ', num2str(estimated_sources)]);
        
        case 'gap'
            estimated_sources = gap_estimation(eigenval_sorted);
            disp(['Número estimado de fontes (GAP) para M = ', ...
                num2str(M), ': ', num2str(estimated_sources)]);
        
        % case 'mdl'
        %     mdl = mdl_estimation(M, eigenval_sorted, snapshots);
        %     [~, estimated_sources] = min(mdl);
        %     disp(['Número estimado de fontes (MDL) para M = ', ...
        %         num2str(M), ': ', num2str(estimated_sources)]);

        otherwise
            error('error. Choice "aic" or "gap"');
    end

    % selecionar autovetores do espaço de ruido
    [~, i] = sort(diag(eigenval), 'descend');
    eigenvec = eigenvec(:, i);
    Vn = eigenvec(:, estimated_sources+1:end);

    % inicializar o pseudoespectro MUSIC
    Pmusic = zeros(size(theta));

    for i = 1:length(theta)
        a = responsearray(M, delta, lambda, theta(i));
        Pmusic(i) = 1 / (a' * (Vn * Vn') * a);
    end

    Pmusic = abs(Pmusic) / max(abs(Pmusic)); 
    musicpseudospectrum = Pmusic;
    eigenval = eigenval_sorted;
end
