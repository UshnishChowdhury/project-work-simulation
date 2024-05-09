%% load test data
%load testdata_serial_1.mat; % Data should be for converter 1
%load testdata_serial_2.mat; % Data should be for converter 2
%load testdata_analyzer.txt; % PCC current?
% load RFPSC_parallel_hw.mat

clear
clc
load RFPSC_parallel_hw.mat

%% Base values

u_N = 24;
i_N = 5;
s_N = u_N*i_N;

%% Calculations:

% stationary - dq
% y_dq = y_s * exp(-1j*theta_g);

% i_c2_d = zeros(length(i_c2.time), 1);
% i_c2_q = zeros(length(i_c2.time), 1);
% 
% for n = 1:length(i_c2.time)
%     i_c2_d(n) = real(i_c2.data(n) * exp(-1j*theta_g.data(n)));
% end

i_c2_d = zeros(length(i_c2.data), 1);
i_c2_q = zeros(length(i_c2.data), 1);

for n = 1:length(i_c2.data)
    i_c2_d(n) = real(i_c2.data(n) * exp(-1j*theta_g.data(n)));
end

% % converter 1
% i_c1_d = real(i_c1.data);
% i_c1_q = imag(i_c1.data);
% p_c1 = 3/2*(u_c1.data .* i_c1_d);
% q_c1 = -3/2*(u_c1.data .* i_c1_q);

% converter 2
% i_c2_dq = (i_c2.data) * exp(-1j*theta_g);
% u_c2_dq = (u_c2.data) * exp(-1j*theta_g);
% 
% i_c2_d = real(i_c2_dq);
% i_c2_q = imag(i_c2_dq);

p_c2 = 3/2*real((u_c2.data .* conj(i_c2.data)));
p_c2_ref = zeros(length(p_c2), 1);

q_c2 = 3/2*imag((u_c2.data .* conj(i_c2.data)));
q_c2_ref = zeros(length(q_c2), 1);


%% Plots

% PCC voltage
% subplot(3,3,1)
% plot(u_pcc.time, u_pcc.data);
% grid on;
% ylabel('PCC voltage (V)');
% xlabel('Time (s)');
% legend('1', '2', 'Location','SouthEast');

% % PCC current
% subplot(4,1,1)
% grid on;
% hold on
% plot(i_g_abc.time, i_g_abc.data(:,1)./i_N, 'r');
% plot(i_g_abc.time, i_g_abc.data(:,2)./i_N, 'g');
% plot(i_g_abc.time, i_g_abc.data(:,3)./i_N, 'b');
% ylabel('Load current (p.u.)');
% % xlabel('Time (s)');
% legend('i_g^a', 'i_g^a', 'i_g^a', 'Location','SouthEast');

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

% % plotting intervals

start1 = 4;
end1 = 4.3;
start2 = 5.0;
end2 = 5.3;
int1 = [start1 end1];
int2 = [start2 end2];

figure
time = i_c2.time;

t = tiledlayout(3,2,'TileSpacing','compact');
bgAx1 = axes(t,'XTick',[],'YTick',[],'Box','off');
bgAx1.Layout.TileSpan = [1 2];

ax1 = axes(t);
hold(ax1, "on")
grid(ax1, "on")
plot(ax1, time, (p_c2)./s_N, 'b')
plot(ax1, time, (q_c2)./s_N, 'r')
hold(ax1, "off")
xline(ax1,end1,':');
ax1.Box = 'off';
xlim(ax1,int1)
xlabel(ax1, 'Connection')
% Create second plot
ax2 = axes(t);
ax2.Layout.Tile = 2;
hold(ax2, "on")
grid(ax2, "on")
plot(ax2, time, (p_c2)./s_N, 'b')
plot(ax2, time, (q_c2)./s_N, 'r')
hold(ax2, "off")
xline(ax2,start2,':');
ax2.YAxis.Visible = 'off';
ax2.Box = 'off';
xlim(ax2,int2)
xlabel(ax2,'Reference change')
ylabel(ax1, 'Power (p.u.)')
% Link the axes
linkaxes([ax1 ax2], 'y')


% Converter 2 power
figure
subplot(3,1,1)
hold on;
plot(i_c2.time, (p_c2)./s_N, 'b');
plot(i_c2.time, (q_c2)./s_N, 'r');
plot(i_c2.time, (p_c2_ref)./s_N, 'lineStyle', '--', 'Color', 'b');
plot(i_c2.time, (q_c2_ref)./s_N, 'lineStyle', '--', 'Color', 'r');
grid on;
xlim([5 5.3])
ylabel('Power (p.u.)');
% xlabel('Time (s)');
legend('p_c', 'q_c', 'Location','SouthEast');
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
subplot(3,1,2)
hold on; grid on;
plot(i_c2.time, i_c2_d./i_N);
plot(i_c2.time, i_c2_q./i_N);
xlim([5 5.3])
ylabel('Converter current (p.u.)');
% xlabel('Time (s)');
legend('i_c^d', 'i_c^q', 'Location','SouthEast');
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
subplot(3,1,3)
hold on;
plot(u_pcc_abc.time, u_pcc_abc.data(:,1)./u_N, 'r');
plot(u_pcc_abc.time, u_pcc_abc.data(:,2)./u_N, 'g');
plot(u_pcc_abc.time, u_pcc_abc.data(:,3)./u_N, 'b');
xlim([5 5.3])
% plot(u_c1.time, abs(u_c1.data));
% plot(u_c2.time, abs(u_c2.data));
grid on;
ylabel('PCC voltage (p.u.)');
xlabel('Time (s)');
legend('u_g^a', 'u_g^b', 'u_g^c', 'Location','SouthEast');
hold off;
