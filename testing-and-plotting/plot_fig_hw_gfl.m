%% load test data
%load testdata_serial_1.mat; % Data should be for converter 1
%load testdata_serial_2.mat; % Data should be for converter 2
%load testdata_analyzer.txt; % PCC current?
% load RFPSC_parallel_hw.mat

clear
clc
load rfpsc-overcurrent.mat

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

u_c2_d = zeros(length(i_c2.data), 1);
u_c2_q = zeros(length(i_c2.data), 1);

u_pcc_a = zeros(length(i_c2.data), 1);
u_pcc_b = zeros(length(i_c2.data), 1);
u_pcc_c = zeros(length(i_c2.data), 1);

% coordinate transformation
for n = 1:length(i_c2.data)
    i_c2_d(n) = real(i_c2.data(n) * exp(-1j*theta_g.data(n)));
    % u_c2_d(n) = real(u_c2.data(n) * exp(-1j*theta_g.data(n)));
    i_c2_q(n) = imag(i_c2.data(n) * exp(-1j*theta_g.data(n)));
    % u_c2_q(n) = imag(u_c2.data(n) * exp(-1j*theta_g.data(n)));
    u_pcc_a(n) = real(u_pcc.data(n));
    u_pcc_b(n) = real(u_pcc.data(n) * exp(-1j*2*pi/3));
    u_pcc_c(n) = real(u_pcc.data(n) * exp(-1j*4*pi/3));
end

% p_c2 = 3/2*real((u_c2.data .* conj(i_c2.data)));
% q_c2 = 3/2*imag((u_c2.data .* conj(i_c2.data)));


% set p_ref and q_ref to 0 when PSC is not enabled
p_c2_ref_fixed = zeros(length(p_c2_ref.data), 1);
q_c2_ref_fixed = zeros(length(p_c2_ref.data), 1);

for n = 1:length(p_c2_ref.data)
    if(PWM_enable.data(n)==0)
        p_c2_ref_fixed(n) = 0;
        q_c2_ref_fixed(n) = 0;
    else
        p_c2_ref_fixed(n) = p_c2_ref.data(n);
        q_c2_ref_fixed(n) = q_c2_ref.data(n);
    end
end


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

% % plotting time variables

start1 = 17.8;
end1 = start1 + 0.1;

start2 = 22.55;
end2 = start2 + 0.1;

start3 = 29.05;
end3 = start3 + 0.1;

start4 = 32.85;
end4 = start4 + 0.1;

int1 = [start1 end1];
int2 = [start2 end2];
int3 = [start3 end3];
int4 = [start4 end4];
time = i_c2.time;
time2 = time + 1.28;
time3 = time2 + 0.06 + 0.007;
ticks1 = start1:0.1:end1;
ticks2 = start2:0.1:end2;
ticks3 = start3:0.1:end3;
ticks4 = start4:0.1:end4;


t = tiledlayout(3,4,'TileSpacing','compact');

% % Converter 2 power

bgAx1 = axes(t,'XTick',[],'YTick',[],'Box','off');
bgAx1.Layout.TileSpan = [1 4];
ax1 = axes(t);
ax1.Layout.Tile = 1;
hold(ax1, "on")
grid(ax1, "on")
plot(ax1, time, (p_c2.data)./s_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax1, time, (q_c2.data)./s_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax1, time2, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2)
plot(ax1, time3, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2)
hold(ax1, "off")
xticks(ax1, ticks1)
ax1.Box = 'off';
xlim(ax1,int1)

ax2 = axes(t);
ax2.Layout.Tile = 2;
hold(ax2, "on")
grid(ax2, "on")
plot(ax2, time, (p_c2.data)./s_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax2, time, (q_c2.data)./s_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax2, time2, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2)
plot(ax2, time3, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2)
hold(ax2, "off")
xticks(ax2, ticks2)
ax2.YAxis.Visible = 'off';
ax2.Box = 'off';
xlim(ax2,int2)

ax3 = axes(t);
ax3.Layout.Tile = 3;
hold(ax3, "on")
grid(ax3, "on")
plot(ax3, time, (p_c2.data)./s_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax3, time, (q_c2.data)./s_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax3, time2, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2)
plot(ax3, time3, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2)
hold(ax3, "off")
xticks(ax3, ticks3)
ax3.YAxis.Visible = 'off';
ax3.Box = 'off';
xlim(ax3,int3)
ylabel(ax1, 'Power (p.u.)')

ax4 = axes(t);
ax4.Layout.Tile = 4;
hold(ax4, "on")
grid(ax4, "on")
plot(ax4, time, (p_c2.data)./s_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax4, time, (q_c2.data)./s_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax4, time2, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2)
plot(ax4, time3, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2)
hold(ax4, "off")
xticks(ax4, ticks4)
ax4.YAxis.Visible = 'off';
legend(ax4, '$p_c$', '$q_c$', '$p_{c,ref}$', '$q_{c,ref}$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
ax4.Box = 'off';
xlim(ax4,int4)

% Link the axes
%linkaxes([ax1 ax3], 'y')
linkaxes([ax1 ax2 ax3 ax4], 'y')

% figure
% subplot(3,1,1)
% hold on;
% plot(i_c2.time, (p_c2)./s_N, 'b');
% plot(i_c2.time, (q_c2)./s_N, 'r');
% plot(i_c2.time, (p_c2_ref)./s_N, 'lineStyle', '--', 'Color', 'b');
% plot(i_c2.time, (q_c2_ref)./s_N, 'lineStyle', '--', 'Color', 'r');
% grid on;
% xlim([5 5.3])
% ylabel('Power (p.u.)');
% % xlabel('Time (s)');
% legend('p_c', 'q_c', 'Location','SouthEast');
% hold off;

bgAx2 = axes(t,'XTick',[],'YTick',[],'Box','off');
bgAx2.Layout.Tile = 5;
bgAx2.Layout.TileSpan = [1 4];
ax5 = axes(t);
ax5.Layout.Tile = 5;
hold(ax5, "on")
grid(ax5, "on")
plot(ax5, time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax5, time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_d./u_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_q./u_N, 'Color', 'r', 'LineWidth', 1.2)
hold(ax5, "off")
xticks(ax5, ticks1)
ax5.Box = 'off';
xlim(ax5,int1)

ax6 = axes(t);
ax6.Layout.Tile = 6;
hold(ax6, "on")
grid(ax6, "on")
plot(ax6, time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax6, time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax5, time, u_c2_d./u_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax5, time, u_c2_q./u_N, 'Color', 'r', 'LineWidth', 1.2)
hold(ax6, "off")
xticks(ax6, ticks2)
ax6.YAxis.Visible = 'off';
ax6.Box = 'off';
xlim(ax6,int2)

ax7 = axes(t);
ax7.Layout.Tile = 7;
hold(ax7, "on")
grid(ax7, "on")
plot(ax7, time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax7, time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_d./u_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_q./u_N, 'Color', 'r', 'LineWidth', 1.2)
hold(ax7, "off")
xticks(ax7, ticks3)
% legend(ax4, '$u_c^d$', '$u_c^q$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
ax7.YAxis.Visible = 'off';
ax7.Box = 'off';
xlim(ax7,int3)
% ylabel(ax4, 'Current (p.u.)')

ax8 = axes(t);
ax8.Layout.Tile = 8;
hold(ax8, "on")
grid(ax8, "on")
plot(ax8, time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax8, time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_d./u_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_q./u_N, 'Color', 'r', 'LineWidth', 1.2)
hold(ax8, "off")
xticks(ax8, ticks1)
legend(ax8, '$i_c^d$', '$i_c^q$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
ax8.Box = 'off';
ax8.YAxis.Visible = 'off';
xlim(ax8,int4)
ylabel(ax5, 'Current (p.u.)')

% Link the axes
%linkaxes([ax4 ax6], 'y')
linkaxes([ax5 ax6 ax7 ax8], 'y')


% % Converter 1 current
% subplot(4,1,3)
% hold on; grid on;
% plot(i_c1.time, i_c1_d);
% plot(i_c1.time, i_c1_q);
% ylabel('Converter current (A)');
% xlabel('Time (s)');
% legend('1', '2', 'Location','SouthEast');
% hold off;

% % Converter 2 current
% subplot(3,1,2)
% hold on; grid on;
% plot(i_c2.time, i_c2_d./i_N);
% plot(i_c2.time, i_c2_q./i_N);
% xlim([5 5.3])
% ylabel('Converter current (p.u.)');
% % xlabel('Time (s)');
% legend('i_c^d', 'i_c^q', 'Location','SouthEast');
% hold off;

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

% % PCC voltage

bgAx3 = axes(t,'XTick',[],'YTick',[],'Box','off');
bgAx3.Layout.Tile = 9;
bgAx3.Layout.TileSpan = [1 4];
ax9 = axes(t);
ax9.Layout.Tile = 9;
hold(ax9, "on")
grid(ax9, "on")
plot(ax9, time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax9, time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax9, time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2)
hold(ax9, "off")
xticks(ax9, ticks1)
ax9.Box = 'off';
xlim(ax9,int1)

ax10 = axes(t);
ax10.Layout.Tile = 10;
hold(ax10, "on")
grid(ax10, "on")
plot(ax10, time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax10, time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax10, time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2)
hold(ax10, "off")
xticks(ax10, ticks2)
ax10.YAxis.Visible = 'off';
ax10.Box = 'off';
xlim(ax10,int2)
label3 = xlabel(bgAx3, 'Time (s)');
label3.Position = [0.5 -0.16 0];

ax11 = axes(t);
ax11.Layout.Tile = 11;
hold(ax11, "on")
grid(ax11, "on")
plot(ax11, time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax11, time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax11, time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2)
hold(ax11, "off")
xticks(ax11, ticks3)
ax11.YAxis.Visible = 'off';
ax11.Box = 'off';
xlim(ax11,int3)
ylabel(ax11, 'Voltage (p.u.)')
label3 = xlabel(bgAx3, 'Time (s)');
label3.Position = [0.5 -0.16 0];

ax12 = axes(t);
ax12.Layout.Tile = 12;
hold(ax12, "on")
grid(ax12, "on")
plot(ax12, time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax12, time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax12, time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2)
hold(ax12, "off")
xticks(ax12, ticks4)
legend(ax12, '$u_g^a$', '$u_g^b$', '$u_g^c$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
ax12.Box = 'off';
xlim(ax12,int4)
ax12.YAxis.Visible = 'off';
% Link the axes
% linkaxes([ax7 ax9], 'y')
linkaxes([ax9 ax10 ax11 ax12], 'y')

% subplot(3,1,3)
% hold on;
% plot(u_pcc_abc.time, u_pcc_abc.data(:,1)./u_N, 'r');
% plot(u_pcc_abc.time, u_pcc_abc.data(:,2)./u_N, 'g');
% plot(u_pcc_abc.time, u_pcc_abc.data(:,3)./u_N, 'b');
% xlim([5 5.3])
% % plot(u_c1.time, abs(u_c1.data));
% % plot(u_c2.time, abs(u_c2.data));
% grid on;
% ylabel('PCC voltage (p.u.)');
% xlabel('Time (s)');
% legend('u_g^a', 'u_g^b', 'u_g^c', 'Location','SouthEast');
% hold off;

plot(i_c2.time, real(i_c2.data));
