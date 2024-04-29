%% Calculations:

% converter 1
i_c1_d = real(i_c1.data);
i_c1_q = imag(i_c1.data);
p_c1 = 3/2*(u_c1.data .* i_c1_d);
q_c1 = -3/2*(u_c1.data .* i_c1_q);

% converter 2
i_c2_d = real(i_c2.data);
i_c2_q = imag(i_c2.data);
p_c2 = 3/2*(u_c2.data .* i_c2_d);
q_c2 = -3/2*(u_c2.data .* i_c2_q);


%% Plots

% PCC voltage
subplot(3,3,1)
plot(u_pcc.time, u_pcc.data);
grid on;
ylabel('PCC voltage (V)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');

% Grid current
subplot(3,3,2)
grid on;
plot(i_g_abc.time, i_g_abc.data(:,1), 'r');
plot(i_g_abc.time, i_g_abc.data(:,2), 'g');
plot(i_g_abc.time, i_g_abc.data(:,3), 'b');
ylabel('Converter current (A)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');

% Converter powers
subplot(3,3,3)
hold on;
plot(i_c1_q.time, p_g);
plot(i_c1.time, q_g);
plot(p_c1_ref.time, p_c1_ref.data, '--');
plot(q_c1_ref.time, q_c1_ref.data, '--');
grid on;
ylabel('Power (kW)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

subplot(3,3,4)
hold on;
plot(i_c2.time, p_g);
plot(i_c2.time, q_g);
plot(p_c2_ref.time, p_c2_ref.data, '--');
plot(q_c2_ref.time, q_c2_ref.data, '--');
grid on;
ylabel('Power (kW)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

% Converter currents
subplot(3,3,5)
hold on; grid on;
plot(i_c1.time, i_c1d);
plot(i_c1.time, i_c1q);
ylabel('Converter current (A)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

subplot(3,3,6)
hold on; grid on;
plot(i_c2.time, i_c2d);
plot(i_c2.time, i_c2q);
ylabel('Converter current (A)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

% power angle
subplot(3,3,7)
hold on; grid on;
plot(theta_c1.time, theta_c1.data / (2*pi) * 360, 'r');
plot(theta_c2.time, theta_c2.data / (2*pi) * 360, 'g');
plot(theta_ref.time, theta_ref.data / (2*pi) * 360 'k--');
ylabel('Angle (deg)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

% DC voltage
subplot(3,3,7)
hold on;
plot(u_c_ref_lim.time, u_c_ref_lim.data);
plot(u_dc.time, u_dc.data/sqrt(3));
plot(u_dc.time, 2/3*u_dc.data);
grid on;
ylabel('Converter voltage (V)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;