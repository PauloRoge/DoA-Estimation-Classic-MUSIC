function steeringvector = responsearray(M, delta, lambda, theta, d)
    % Compute the near-field steering vector for a ULA
    % M: Number of antennas
    % delta: Antenna spacing
    % lambda: Wavelength
    % theta: Angle of arrival (degrees)
    % d: Distance to the source (meters)
    
    theta_rad = deg2rad(theta); % Convert angle to radians
    k = 2 * pi / lambda; % Wavenumber
    m = (0:M-1)'; % Antenna index
    
    % near-field steering vector with enhanced curvature model
    phase_term = k * delta * (m - 1) * sin(theta_rad);
    curvature_term = -pi * (delta^2 / (lambda * d)) * cos(theta_rad)^2 * (m - 1).^2;
    amplitude_term = exp(-1j * k * (m - 1).^2 * delta^2 / (2 * d));
    steeringvector = amplitude_term .* exp(1j * (phase_term + curvature_term));
end
