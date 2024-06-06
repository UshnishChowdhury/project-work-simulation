%% Clear memory etc.
clear;                  % Remove variables from the workspace
clc;                    % Clear screen
close all;              % Close all figures

%% Controller parameters
% System parameters
L_f = 1e-3;            % Inductance of the filter inductor
L_f1 = L_f;
L_f2 = L_f;
w_N = 2*pi*50;          % Grid angular frequency
u_gN = 24;              % Nominal grid voltage (phase-to-neutral, peak value)
w0_pll = 2*pi*20;
R_L = 12;               % Load resistance
L_g = 2.5e-3;           % Grid inductance
U_dc = 48;              % DC bus voltage

% PWM and current controller
f_sw = 5e3;            % Switching frequency
T_s = 1/(2*f_sw);       % Sampling period
alpha_c = 2*pi*400;     % Current-control bandwidth

% Hardware PWM
f_clk = 90e6;           % processor clock speed
div = 1;                % system clock divider
carr = 2;               % carrier style, 2 for up-down
T_pwm = f_clk/(div*f_sw*carr); % PWM timer period

% PSC/RFPSC controller parameters
w_b = 0.1*w_N;          % Filter bandwidth
R_a = 0.32;             % Active resistance
K = 1;                  % Space vector scaling constant
kpp = 3/2 * K^(-2);     % Peak value vector scaling
K_p = 3*w_N*R_a/(2*u_gN^2*kpp); % Active power control gain

I_max = 10;              % Current limit for software overcurrent protection
U_dcmin = 35;           % Minimum DC voltage

n=500;                  % Number of data points (samples) in one packet

port='COM4';            % COM port for serial communication