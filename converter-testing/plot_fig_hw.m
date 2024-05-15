%% load test data
%load testdata_serial_1.mat; % Data should be for converter 1
%load testdata_serial_2.mat; % Data should be for converter 2
%load testdata_analyzer.txt; % PCC current?
% load RFPSC_parallel_hw.mat

clear
clc
load rfpsc_parallel_hwtrigger_c1.mat

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

start1 = 22.5;
end1 = start1 + 0.3;

start2 = 27.1;
end2 = start2 + 0.3;

start3 = 35.2;
end3 = start3 + 0.3;

int1 = [start1 end1];
int2 = [start2 end2];
int3 = [start3 end3];
time = i_c2.time;
time2 = time + 0.35;
ticks1 = start1:0.1:end1;
ticks2 = start2:0.1:end2;
ticks3 = start3:0.1:end3;


t = tiledlayout(3,3,'TileSpacing','compact');

% % Converter 2 power

bgAx1 = axes(t,'XTick',[],'YTick',[],'Box','off');
bgAx1.Layout.TileSpan = [1 3];
ax1 = axes(t);
ax1.Layout.Tile = 1;
hold(ax1, "on")
grid(ax1, "on")
plot(ax1, time, (p_c2.data)./s_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax1, time, (q_c2)./s_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax1, time2, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2)
plot(ax1, time2, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2)
hold(ax1, "off")
xticks(ax1, ticks1)
ax1.Box = 'off';
xlim(ax1,int1)

ax2 = axes(t);
ax2.Layout.Tile = 2;
hold(ax2, "on")
grid(ax2, "on")
plot(ax2, time, (p_c2.data)./s_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax2, time, (q_c2)./s_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax2, time2, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2)
plot(ax2, time2, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2)
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
% plot(ax3, time, (q_c2)./s_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax3, time2, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2)
plot(ax3, time2, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2)
hold(ax3, "off")
xticks(ax3, ticks3)
legend(ax3, '$p_c$', '$q_c$', '$p_{c,ref}$', '$q_{c,ref}$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
ax3.YAxis.Visible = 'off';
ax3.Box = 'off';
xlim(ax3,int3)
ylabel(ax1, 'Power (p.u.)')

% Link the axes
%linkaxes([ax1 ax3], 'y')
linkaxes([ax1 ax2 ax3], 'y')

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
bgAx2.Layout.Tile = 4;
bgAx2.Layout.TileSpan = [1 3];
ax4 = axes(t);
ax4.Layout.Tile = 4;
hold(ax4, "on")
grid(ax4, "on")
plot(ax4, time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax4, time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_d./u_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_q./u_N, 'Color', 'r', 'LineWidth', 1.2)
hold(ax4, "off")
xticks(ax4, ticks1)
ax4.Box = 'off';
xlim(ax4,int1)

ax5 = axes(t);
ax5.Layout.Tile = 5;
hold(ax5, "on")
grid(ax5, "on")
plot(ax5, time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax5, time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax5, time, u_c2_d./u_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax5, time, u_c2_q./u_N, 'Color', 'r', 'LineWidth', 1.2)
hold(ax5, "off")
xticks(ax5, ticks2)
ax5.YAxis.Visible = 'off';
ax5.Box = 'off';
xlim(ax5,int2)

ax6 = axes(t);
ax6.Layout.Tile = 6;
hold(ax6, "on")
grid(ax6, "on")
plot(ax6, time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2)
plot(ax6, time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_d./u_N, 'Color', 'b', 'LineWidth', 1.2)
% plot(ax4, time, u_c2_q./u_N, 'Color', 'r', 'LineWidth', 1.2)
hold(ax6, "off")
xticks(ax6, ticks3)
legend(ax6, '$i_c^d$', '$i_c^q$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
% legend(ax4, '$u_c^d$', '$u_c^q$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
ax6.YAxis.Visible = 'off';
ax6.Box = 'off';
xlim(ax6,int3)
% ylabel(ax4, 'Current (p.u.)')
ylabel(ax4, 'Current (p.u.)')

% Link the axes
%linkaxes([ax4 ax6], 'y')
linkaxes([ax4 ax5 ax6], 'y')


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
bgAx3.Layout.Tile = 7;
bgAx3.Layout.TileSpan = [1 3];
ax7 = axes(t);
ax7.Layout.Tile = 7;
hold(ax7, "on")
grid(ax7, "on")
plot(ax7, time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax7, time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax7, time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2)
hold(ax7, "off")
xticks(ax7, ticks1)
ax7.Box = 'off';
xlim(ax7,int1)

ax8 = axes(t);
ax8.Layout.Tile = 8;
hold(ax8, "on")
grid(ax8, "on")
plot(ax8, time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax8, time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax8, time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2)
hold(ax8, "off")
xticks(ax8, ticks2)
ax8.YAxis.Visible = 'off';
ax8.Box = 'off';
xlim(ax8,int2)
label3 = xlabel(bgAx3, 'Time (s)');
label3.Position = [0.5 -0.16 0];

ax9 = axes(t);
ax9.Layout.Tile = 9;
hold(ax9, "on")
grid(ax9, "on")
plot(ax9, time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax9, time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax9, time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2)
hold(ax9, "off")
xticks(ax9, ticks3)
legend(ax9, '$u_g^a$', '$u_g^b$', '$u_g^c$', 'Location', 'eastoutside', 'Interpreter', 'latex', 'FontSize', 11)
ax9.YAxis.Visible = 'off';
ax9.Box = 'off';
xlim(ax9,int3)
ylabel(ax7, 'Voltage (p.u.)')
label3 = xlabel(bgAx3, 'Time (s)');
label3.Position = [0.5 -0.16 0];

% Link the axes
% linkaxes([ax7 ax9], 'y')
linkaxes([ax7 ax8 ax9], 'y')

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
