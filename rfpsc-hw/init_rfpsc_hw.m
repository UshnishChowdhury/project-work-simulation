%% Clear memory etc.
clear;                  % Remove variables from the workspace
clc;                    % Clear screen
close all;              % Close all figures

%% Controller parameters
% System parameters
L_f = 1e-3;            % Inductance of the filter inductor
L_f1 = L_f;
L_f2 = L_f;
C = 1e-3;               % DC-bus capacitance
w_g = 2*pi*50;          % Grid angular frequency
u_gN = 24;              % Nominal grid voltage (phase-to-neutral, peak value)
w0_pll = 2*pi*20;
R_L = 12;               % Load resistance
L_g = 2.5e-3;           % Grid inductance
U_dc = 48;              % DC bus voltage

% PWM and current controller
f_sw = 10e3;            % Switching frequency
T_s = 1/(2*f_sw);       % Sampling period
alpha_c = 2*pi*400;     % Current-control bandwidth

% Hardware PWM
f_clk = 90e6;           % processor clock speed
div = 1;                % system clock divider
carr = 2;               % carrier style, 2 for up-down
T_pwm = f_clk/(div*f_sw*carr); % PWM timer period

% Reference parameters
E_p = 24.0;             % Reference grid voltage

% RFPSC controller parameters
w_b = 0.1*w_g;          % Filter bandwidth
R_a = 0.32;             % Active resistance
K_p = 3*w_g*R_a/(2*u_gN^2); % Active power control gain