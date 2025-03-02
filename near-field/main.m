close all; clear; clc

architecture = 16;                  % numeros de antenas em x e y
frequency = 3e9;                    % 3 GHz
lambda = (3e8) / frequency;         % comprimento de onda
delta = lambda/2;                   % antenna spacing
snapshots = 200;                    % number of samples
power = 0.1;                        % transmission power (w)
noisepowerdBm = -90;                % noise power in dBm
AoA = [-53 -12 48 55];              % angles of arrival (degrees)
d = [4 10 6 12];                    % relative distances (m)
source = length(AoA);               % number of sources
alpha = 2;                          % pathloss exponent
theta = -90:1:90;                   % angle range
d_range = linspace(3, 15, 200);     % distance range for 2D MUSIC

% fonte do plot
set(groot,'defaultAxesTickLabelInterpreter','latex');

figure;
hold on; box on; 

for ii = 1:length(architecture)
    M = architecture(ii);
    Y = signals(M, snapshots, delta, lambda, AoA, source, d, alpha, power, noisepowerdBm);
    Pmusic = music(Y, M, theta, d_range, snapshots, delta, lambda);
    
    % Plot the MUSIC spectrum
    surf(theta, d_range, 10 * log10(Pmusic.'), 'EdgeColor', 'none');
    colormap jet; 
    
    % Set axis properties
    ax = gca;
    xlabel('Angle (degrees)','FontSize', 12);
    ylabel('Distance (m)','FontSize', 12);
    set(gca,'fontsize',14);
    shading interp;
    view(0,90);
    axis tight;
    
    % Add colorbar
    hBar = colorbar;
    clim([min(10 * log10(Pmusic(:))), max(10 * log10(Pmusic(:)))]);
end

hold off;
