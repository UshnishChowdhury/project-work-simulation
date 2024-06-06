%% load test data
%load testdata_serial_1.mat; % Data should be for converter 1
%load testdata_serial_2.mat; % Data should be for converter 2
%load testdata_analyzer.txt; % PCC current?
load RFPSC_parallel_sim_plot.mat

%% Calculations:

% converter 1
i_c1_d = real(i_c1.data);
i_c1_q = imag(i_c1.data);
% p_c1 = 3/2*(u_c1.data .* i_c1_d);
% q_c1 = -3/2*(u_c1.data .* i_c1_q);

% % converter 2
i_c2_d = real(i_c2.data);
i_c2_q = imag(i_c2.data);
% p_c2 = 3/2*(u_c2.data .* i_c2_d);
% q_c2 = -3/2*(u_c2.data .* i_c2_q);


%% Plots

% PCC voltage
% subplot(3,3,1)
% plot(u_pcc.time, u_pcc.data);
% grid on;
% ylabel('PCC voltage (V)');
% xlabel('Time (s)');
% legend('1', '2', 'Location','SouthEast');

% PCC current
subplot(4,1,1)
grid on;
hold on
plot(i_g_abc.time, i_g_abc.data(:,1), 'r');
plot(i_g_abc.time, i_g_abc.data(:,2), 'g');
plot(i_g_abc.time, i_g_abc.data(:,3), 'b');
ylabel('Converter current (A)');
xlabel('Time (s)');
legend('i_g^a', 'Phase B', 'Phase C', 'Location','SouthEast');

% % Converter 1 power
% subplot(4,1,2)
% hold on;
% plot(p_g.time, p_g.data);
% plot(q_g.time, q_g.data);
% plot(p_ref1.time, p_ref1.data, '--');
% plot(q_ref1.time, q_ref2.data, '--');
% grid on;
% ylabel('Power (kW)');
% xlabel('Time (s)');
% legend('1', '2', 'Location','SouthEast');
% hold off;

% Converter 2 power
subplot(4,1,2)
hold on;
plot(p_c2.time, p_c2.data, 'b');
plot(q_c2.time, q_c2.data, 'r');
plot(p_ref2.time, p_ref2.data, 'lineStyle', '--', 'Color', 'b');
plot(q_ref2.time, q_ref2.data, 'lineStyle', '--', 'Color', 'r');
grid on;
ylabel('Power (kW)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

% % Converter 1 current
% subplot(4,1,3)
% hold on; grid on;
% plot(i_c1.time, i_c1_d);
% plot(i_c1.time, i_c1_q);
% ylabel('Converter current (A)');
% xlabel('Time (s)');
% legend('1', '2', 'Location','SouthEast');
% hold off;

% Converter 2 current
subplot(4,1,3)
hold on; grid on;
plot(i_c2.time, i_c2_d);
plot(i_c2.time, i_c2_q);
ylabel('Converter current (A)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

% % Power angle
% subplot(3,3,7)
% hold on; grid on;
% plot(theta_c1.time, theta_c1.data / (2*pi) * 360, 'r');
% plot(theta_c2.time, theta_c2.data / (2*pi) * 360, 'g');
% plot(theta_ref.time, theta_ref.data / (2*pi) * 360, 'k', '--');
% ylabel('Angle (deg)');
% xlabel('Time (s)');
% legend('1', '2', 'Location','SouthEast');
% hold off;

% Converter and grid voltage magnitudes
subplot(4,1,4)
hold on;
plot(u_pcc_abc.time, u_pcc_abc.data(:,1), 'r');
plot(u_pcc_abc.time, u_pcc_abc.data(:,2), 'g');
plot(u_pcc_abc.time, u_pcc_abc.data(:,3), 'b');
% plot(u_c1.time, abs(u_c1.data));
% plot(u_c2.time, abs(u_c2.data));
grid on;
ylabel('PCC voltage (V)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;
