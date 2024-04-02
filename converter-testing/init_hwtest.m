%% Clear memory etc.
% clear;                  % Remove variables from the workspace
% clc;                    % Clear screen
% close all;              % Close all figures

%% Controller parameters
% System parameters
L_f = 1e-3;            % Inductance of the filter inductor
C = 1e-3;               % DC-bus capacitance
w_g = 2*pi*50;          % Grid angular frequency
u_gN = 24;              % Nominal grid voltage (phase-to-neutral, peak value)

% PWM and current controller
f_sw = 20e3;             % Switching frequency
T_s = 1/(2*f_sw);       % Sampling period
alpha_c = 2*pi*400;     % Current-control bandwidth

% Reference parameters
E_p = 24.0;
% Hardware PWM
f_clk = 90e6;           % processor clock speed
div = 1;                % system clock divider
carr = 2;               % carrier style, 2 for up-down
T_pwm = f_clk/(div*f_sw*carr); % PWM timer period
