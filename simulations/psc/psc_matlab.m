% Active power calculation
P = kpp*real(u_c_ref*conj(i_c));

% Equation for grid angular frequency
w_g = (P_ref - P)*K_p + w_1;

% Update (integrate) the grid voltage angle
theta_next = theta + T_s * w_g; 

%Limiting theta value -pi <= theta <= pi
if(theta_next > pi)
    theta_next = theta_next - 2*pi;
elseif(theta_next < -pi)
    theta_next = theta_next + 2*pi;
end

% Extracting the real and imaginary values of the complex converter current
i_c_real = real(i_c);
i_c_imag = imag(i_c);

% Applying highpass filter equation to real and imaginary parts of the
% converter current
i_c_real_filt_next =  i_c_filt_real*(1 - w_b*T_s) + i_c_real*(w_b*T_s);
i_c_imag_filt_next =  i_c_filt_imag*(1 - w_b*T_s) + i_c_imag*(w_b*T_s);

% Equation for reference voltage
u_c = V - ((i_c_real - i_c_real_filt_next) ...
    + 1j*(i_c_imag - i_c_imag_filt_next)) * R_a;

% Inverse coordinate transformation with discrete time compensation
u_cs = u_c*exp(1j*(theta + 1.5 * T_s * w_1));