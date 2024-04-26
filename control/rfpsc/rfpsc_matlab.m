% Active power calculation
P = kpp*real(u_c_ref*conj(i_c));

% Equation for grid angular frequency
w_g = (P_ref - P)*K_p + w_1;

% Update (integrate) the grid voltage angle
theta_next = theta + T_s * w_g;
while(theta_next > pi)
    theta_next = theta_next - 2*pi;
end
while(theta_next < -pi)
    theta_next = theta_next + 2*pi;
end

% Extracting the real and imaginary values of the complex converter current
i_c_imag = imag(i_c);

% Applying lowpass filter equation to imaginary part of the
% converter current and forming reference current based on power reference
i_c_filt_next =  i_c_filt*(1 - w_b*T_s) + i_c_imag*(w_b*T_s);

i_ref = P_ref/(V*kpp) + 1j*i_c_filt_next;

% Equation for reference voltage
u_c = V + (i_ref-i_c) * R_a;

% Inverse coordinate transformation
u_cs = u_c*exp(1j*(theta + 1.5 * T_s * w_g));
