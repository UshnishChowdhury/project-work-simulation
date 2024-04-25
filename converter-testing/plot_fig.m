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

% PCC


%% Plots

subplot(3,3,1)
plot(u_pcc.time, u_pcc.data);
grid on;
ylabel('PCC voltage (V)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');

subplot(3,3,2)
hold on;
plot(i_c.time, p_g);
plot(i_c.time, q_g);
plot(p_g_ref.time, p_g_ref.data);
plot(q_g_ref.time, q_g_ref.data);
grid on;
ylabel('Power (kW)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

subplot(3,3,3)
grid on;
plot(i_c_abc.time, i_c_abc.data);
ylabel('Converter current (A)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');

subplot(3,3,4)
hold on; grid on;
plot(i_c.time, i_cd);
plot(i_c.time, i_cq);
plot(i_c_ref.time, real(i_c_ref.data));
plot(i_c_ref.time, imag(i_c_ref.data));
ylabel('Converter current (A)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

% power angle
subplot(3,3,5)
hold on; grid on;
plot(theta_c1.time, theta_c1.data / (2*pi) * 360);
plot(theta_c2.time, theta_c2.data / (2*pi) * 360);
plot(theta_ref.time, theta_ref.data / (2*pi) * 360);
ylabel('Angle (deg)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;

subplot(3,3,6)
hold on;
plot(u_c_ref_lim.time, u_c_ref_lim.data);
plot(u_dc.time, u_dc.data/sqrt(3));
plot(u_dc.time, 2/3*u_dc.data);
grid on;
ylabel('Converter voltage (V)');
xlabel('Time (s)');
legend('1', '2', 'Location','SouthEast');
hold off;