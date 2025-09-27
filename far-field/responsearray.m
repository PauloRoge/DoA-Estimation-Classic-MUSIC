function steeringvector = responsearray(M, d_antenna, lambda, theta)
    gamma = (2*pi * d_antenna)/lambda;
    steeringvector = exp(-1i*gamma*(0:M-1)'*sind(theta));
end
