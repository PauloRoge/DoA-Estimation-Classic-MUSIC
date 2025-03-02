close all; clear ;clc

architecture = [8 32 64];       % quantidade de antenas no array
frequency = 3*10^9;             % 6 GHz
lambda = (3*10^8) / frequency;  % comprimento de onda
delta = lambda/2;               % espaçamento entre antenas em comprimentos de onda
snapshots = 200;                % amostras
power = 0.1;                    % potencia transmitida (w)
noisepowerdBm = -90;            % potencia de ruido em (dBm)
AoA = [-53 -12 48 55];          % angulos de chegada dos alvos (graus)
d = [50 24 130 192];            % distancia relativa (m)
source = length(AoA);           % quantidade de fontes
alpha = 2;                      % expoente pathloss (free space)
theta = -90:1:90;               % geracao do Pseudo Espectro MUSIC
method = 'aic';                 % metodos: aic, gap, mdl.

% criar a figura para o pseudoespectro MUSIC
figure; 
hold on;

for ii = 1:length(architecture)

    M = architecture(ii); % numero de antenas
    Y = signals(M, snapshots, delta, lambda, AoA, source, d, alpha, power, noisepowerdBm);
    
    % chamada da função MUSIC, que agora retorna os autovalores também
    [Pmusic, eigenvalues] = music(Y, M, theta, snapshots, delta, lambda, method);
    
    % plot do pseudoespectro MUSIC
    colors = {[0.3, 0.3, 0.3], 'b', 'r'}; 
    plot(theta, 10 * log10(Pmusic), 'Color', colors{mod(ii, length(colors))+1}, ...
        'DisplayName', ['M = ' num2str(M)]); 
end

% adicionar entrada adicional para AoA e distancia na legenda
legend_entry = sprintf('AoA: %s \nDistance: %s (m)', strjoin(string(AoA), ', '), strjoin(string(d), ', '));
plot(nan, nan, 'Color', 'none', 'DisplayName', legend_entry);
xlabel('Angle (degrees)');
ylabel('Pseudo Spectrum (dB)');
grid on;
legend show;
hold off;