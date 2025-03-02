function musicpseudospectrum = music(Y, M, theta, d, snapshots, delta, lambda)

    R = (Y * Y') / snapshots; % covariance matrix
    
    [eigenvectors, eigenvalues] = eig(R); % eigen decomposition
    eigenvalues_sorted = sort(diag(eigenvalues), 'descend');
    eigenvalues_sorted = eigenvalues_sorted / sum(eigenvalues_sorted);
    
    aic = estimation(M, eigenvalues_sorted, snapshots); % AIC estimation
    [~, estimated_sources] = min(aic);
    disp(['Estimated number of sources (AIC) for M = ', num2str(M), ': ', num2str(estimated_sources)]);
    
    [~, i] = sort(diag(eigenvalues), 'descend');
    eigenvectors = eigenvectors(:, i);
    Vn = eigenvectors(:, estimated_sources+1:end);
    
    Pmusic = zeros(length(theta), length(d));
    
    for i = 1:length(theta)
        for j = 1:length(d)
            a = responsearray(M, delta, lambda, theta(i), d(j));
            Pmusic(i, j) = 1 / (a' * (Vn * Vn') * a);
        end
    end
    
    Pmusic = abs(Pmusic) / max(abs(Pmusic(:))); % Normalize spectrum
    musicpseudospectrum = Pmusic;
end