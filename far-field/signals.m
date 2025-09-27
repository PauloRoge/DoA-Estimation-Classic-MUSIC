function [Y,Z] = signals(M, snapshots, delta, lambda, AoA, ...
    source, d, expoentpathloss, transmittedpower, noisepowerdBm)
    
    noisepower = 10^((noisepowerdBm - 30) / 10);

    % inicializar matriz de canal e pathloss
    H = zeros(M, source);
    beta = zeros(source, 1);

    % matriz de canal
    for s = 1:source
        beta(s) = sqrt(lambda^expoentpathloss / ((4*pi*d(s)) ^ expoentpathloss)); 
        A = responsearray(M, delta, lambda, AoA(s));
        H(:, s) = beta(s) * A;
    end

    X = sqrt(transmittedpower) * randn(source, snapshots)/ sqrt(2); % sinais transmitidos
    Z = sqrt(noisepower) * (randn(M, snapshots) + 1j * randn(M, snapshots)) / sqrt(2); 
    Y = H * X + Z;

    % cálculo da SNR para verificação
    % SNR = 10 * log10(sum(abs(Y).^2, 'all') / sum(abs(Z).^2, 'all'));
    % disp(['SNR = ', num2str(SNR), ' dB']);
end
