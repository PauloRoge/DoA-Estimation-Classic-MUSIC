function [musicpseudospectrum, eigenval] = music(Y, M, ...
    theta, snapshots, delta, lambda, k)
    
    R = (Y * Y') / snapshots; % matriz de covariancia media

    % decomposição em autovalores e autovetores
    [eigenvec, eigenval] = eig(R);
    eigenval_sorted = sort(diag(eigenval), 'descend'); 
    eigenval_sorted = eigenval_sorted / sum(eigenval_sorted); 

    % selecionar autovetores do espaço de ruido
    [~, i] = sort(diag(eigenval), 'descend');
    eigenvec = eigenvec(:, i);
    Vn = eigenvec(:, k+1:end);

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
