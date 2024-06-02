%% load test data
clear
clc
%load rfpsc-ppt-1.mat
%load psc_testdata.mat
%load gfl-ppt-1.mat
%load rfpsc-voltage-freq-change.mat
%load psc_fault.mat
load gfl_fault.mat

%% Base values
u_N = 24;
i_N = 5;
s_N = u_N*i_N;

%% Calculations:

i_c2_d = zeros(length(i_c2.data), 1);
i_c2_q = zeros(length(i_c2.data), 1);

u_c2_d = zeros(length(i_c2.data), 1);
u_c2_q = zeros(length(i_c2.data), 1);

u_pcc_a = zeros(length(i_c2.data), 1);
u_pcc_b = zeros(length(i_c2.data), 1);
u_pcc_c = zeros(length(i_c2.data), 1);


% Coordinate transformation
for n = 1:length(i_c2.data)
    i_c2_d(n) = real(i_c2.data(n) * exp(-1j*theta_g.data(n)));
    i_c2_q(n) = imag(i_c2.data(n) * exp(-1j*theta_g.data(n)));
    u_pcc_a(n) = real(u_pcc.data(n));
    u_pcc_b(n) = real(u_pcc.data(n) * exp(-1j*2*pi/3));
    u_pcc_c(n) = real(u_pcc.data(n) * exp(-1j*4*pi/3));
end

%% Plot timings

power_ref_offset_time_for_rfpsc = i_c2.time + 4.2832;
rfpsc_connection_start_time = 31.434;
rfpsc_p_ref_tracking_start_time = 36.1844;
rfpsc_disconnection_start_time = 44.998;

rfpsc_connection_time = 31.4764;
rfpsc_p_ref_tracking_time = 36.1996;
rfpsc_disconnection_time = 45.0316;

power_ref_offset_time_for_psc = i_c2.time + 0.5276;
psc_connection_start_time = 11.7756;
psc_p_ref_tracking_start_time = 16.8056;
psc_disconnection_start_time = 23.2148;

psc_connection_time = 11.794;
psc_p_ref_tracking_time = 16.8336;
psc_disconnection_time = 23.23;

active_power_ref_offset_time_for_gfl = i_c2.time + 1.28;
reactive_power_ref_offset_time_for_gfl = active_power_ref_offset_time_for_gfl + 0.066;
gfl_connection_start_time = 17.8092;
gfl_p_ref_tracking_start_time = 22.5548;
gfl_q_ref_tracking_start_time = 29.05;
gfl_disconnection_start_time = 32.85;

gfl_connection_time = 17.8346;
gfl_p_ref_tracking_time = 22.5722;
gfl_q_ref_tracking_time = 29.087;
gfl_disconnection_time = 32.896;

rfpsc_fault_voltage_change_time = 17.65;
rfpsc_fault_frequency_change_time = 28.27;
rfpsc_volt_change_time = 17.6828;
rfpsc_freq_change_time = 28.3008;

psc_fault_voltage_change_time = 24.6212;
psc_fault_frequency_change_time = 36.0244;
psc_volt_change_time = 24.6564;
psc_freq_change_time = 36.0552;

gfl_fault_voltage_change_time = 43.166;
gfl_fault_frequency_change_time = 56.7932;
gfl_volt_change_time = 43.1976;
gfl_freq_change_time = 56.8232;

connection_start_time = gfl_connection_start_time;
p_ref_tracking_start_time = gfl_p_ref_tracking_start_time;
q_ref_tracking_start_time = gfl_q_ref_tracking_start_time;
disconnection_start_time = gfl_disconnection_start_time;

connection_time = gfl_connection_time;
p_ref_tracking_time = gfl_p_ref_tracking_time;
q_ref_tracking_time = gfl_q_ref_tracking_time;
disconnection_time = gfl_disconnection_time;

p_ref_tracking_offset_time = active_power_ref_offset_time_for_gfl;

grid_fault_volt_time = gfl_fault_voltage_change_time;
grid_fault_freq_time = gfl_fault_frequency_change_time;

grid_fault_volt_change_time = gfl_volt_change_time;
grid_fault_freq_change_time = gfl_freq_change_time;

gfl_end_time = 0.075;
gfm_end_time = 0.1;
end_time = gfm_end_time;
x_tick_division = end_time/2;

%% GFM Plots
% t = tiledlayout(3, 3, 'TileSpacing', 'tight', 'Padding', 'tight');
% 
% ax1 = axes(t);
% ax1.Layout.Tile = 1;
% hold(ax1, "on");
% plot(ax1, p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax1, q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
% plot(ax1, p_ref_tracking_offset_time, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% xline(connection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax1, "on");
% ylabel('Power (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
% hold(ax1, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim([connection_start_time connection_start_time+end_time]);
% ylim([-0.75 0.75]);
% title('Parallel converter connection', 'Interpreter', 'latex', 'FontSize', 12);
% 
% ax2 = axes(t);
% ax2.Layout.Tile = 2;
% hold(ax2, "on");
% plot(p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
% plot(p_ref_tracking_offset_time, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% xline(p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax2, "on");
% hold(ax2, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim([p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim([-0.75 0.75]);
% title('Active power reference tracking', 'Interpreter', 'latex', 'FontSize', 12);
% 
% ax3 = axes(t);
% ax3.Layout.Tile = 3;
% hold(ax3, "on");
% plot(p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
% plot(p_ref_tracking_offset_time, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% xline(disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax3, "on");
% legend('$p_c$', '$q_c$', '$p_{c,ref}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax3, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim([disconnection_start_time disconnection_start_time+end_time]);
% ylim([-0.75 0.75]);
% title('Islanded mode (single converter)', 'Interpreter', 'latex', 'FontSize', 12);
% 
% linkaxes([ax1 ax2 ax3], 'y');
% 
% ax4 = axes(t);
% ax4.Layout.Tile = 4;
% hold(ax4, "on");
% plot(ax4, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax4, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
% xline(connection_time, 'LineStyle', '--', 'LineWidth',1.2);
% grid(ax4, "on");
% ylabel('Current (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
% hold(ax4, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim([connection_start_time connection_start_time+end_time]);
% ylim([-0.75 0.75]);
% 
% ax5 = axes(t);
% ax5.Layout.Tile = 5;
% hold(ax5, "on");
% plot(ax5, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax5, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
% xline(p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax5, "on");
% hold(ax5, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim([p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim([-0.75 0.75]);
% 
% ax6 = axes(t);
% ax6.Layout.Tile = 6;
% hold(ax6, "on");
% plot(ax6, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax6, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
% xline(disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax6, "on");
% legend('$i_{cd}$', '$i_{cq}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax6, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim([disconnection_start_time disconnection_start_time+end_time]);
% ylim([-0.75 0.75]);
% 
% linkaxes([ax4 ax5 ax6], 'y');
% 
% ax7 = axes(t);
% ax7.Layout.Tile = 7;
% hold(ax7, "on");
% plot(ax7, theta_g.time, theta_g.data .* 180/pi, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax7, theta_c.time, theta_c.data .* 180/pi, 'Color', 'r', 'LineWidth', 1.2, 'LineStyle','--');
% xline(connection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax7, "on");
% ylabel('Angle (deg)', 'Interpreter', 'latex', 'FontSize', 12);
% hold(ax7, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-180:90:180));
% xlim([connection_start_time connection_start_time+end_time]);
% ylim([-200 200]);
% 
% ax8 = axes(t);
% ax8.Layout.Tile = 8;
% hold(ax8, "on");
% plot(ax8, theta_g.time, theta_g.data .* 180/pi, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax8, theta_c.time, theta_c.data .* 180/pi, 'Color', 'r', 'LineWidth', 1.2, 'LineStyle','--');
% xline(p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax8, "on");
% hold(ax8, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-180:90:180));
% xlim([p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim([-200 200]);
% 
% ax9 = axes(t);
% ax9.Layout.Tile = 9;
% hold(ax9, "on");
% plot(ax9, theta_g.time, theta_g.data .* 180/pi, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax9, theta_c.time, theta_c.data .* 180/pi, 'Color', 'r', 'LineWidth', 1.2, 'LineStyle','--');
% xline(disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax9, "on");
% legend('$\vartheta_{g}$', '$\vartheta_{c}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax9, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-180:90:180));
% xlim([disconnection_start_time disconnection_start_time+end_time]);
% ylim([-200 200]);
% 
% linkaxes([ax7 ax8 ax9], 'y');
% 
% ax7 = axes(t);
% ax7.Layout.Tile = 7;
% hold(ax7, "on");
% plot(ax7, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax7, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
% plot(ax7, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
% xline(connection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax7, "on");
% hold(ax7, "off");
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.0:0.5:1.0));
% ylabel(ax7, 'Voltage (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
% xlim([connection_start_time connection_start_time+end_time]);
% ylim([-1.5 1.5]);
% 
% ax8 = axes(t);
% ax8.Layout.Tile = 8;
% hold(ax8, "on");
% plot(ax8, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax8, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
% plot(ax8, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
% xline(p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax8, "on");
% hold(ax8, "off");
% h = gca;
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.0:0.5:1.0));
% xlim([p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim([-1.5 1.5]);
% 
% ax9 = axes(t);
% ax9.Layout.Tile = 9;
% hold(ax9, "on");
% plot(ax9, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax9, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
% plot(ax9, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
% xline(disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax9, "on");
% legend(ax9, '$u_g^a$', '$u_g^b$', '$u_g^c$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax9, "off");
% h = gca;
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.0:0.5:1.0));
% xlim([disconnection_start_time disconnection_start_time+end_time]);
% ylim([-1.5 1.5]);
% 
% linkaxes([ax7 ax8 ax9], 'y');
% 
% xlabel(t, 'Time (s)', 'Interpreter', 'latex', 'FontSize', 10);

%% GFL Plots
% t = tiledlayout(3, 4, 'TileSpacing', 'tight', 'Padding', 'tight');
% 
% ax1 = axes(t);
% ax1.Layout.Tile = 1;
% hold(ax1, "on");
% plot(ax1, p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax1, q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
% plot(ax1, active_power_ref_offset_time_for_gfl, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% plot(ax1, reactive_power_ref_offset_time_for_gfl, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2);
% xline(ax1, connection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax1, "on");
% ylabel('Power (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
% hold(ax1, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.5:0.5:1.5));
% xlim(ax1, [connection_start_time connection_start_time+end_time]);
% ylim(ax1, [-1.5 1.5]);
% title('Parallel converter connection', 'Interpreter', 'latex', 'FontSize', 12);
% 
% ax2 = axes(t);
% ax2.Layout.Tile = 2;
% hold(ax2, "on");
% plot(ax2, p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax2, q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
% plot(ax2, active_power_ref_offset_time_for_gfl, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% plot(ax2, reactive_power_ref_offset_time_for_gfl, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2);
% xline(ax2, p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax2, "on");
% hold(ax2, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.5:0.5:1.5));
% xlim(ax2, [p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim(ax2, [-1.5 1.5]);
% title('Active power reference tracking', 'Interpreter', 'latex', 'FontSize', 12);
% 
% ax3 = axes(t);
% ax3.Layout.Tile = 3;
% hold(ax3, "on");
% plot(ax3, p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax3, q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
% plot(ax3, active_power_ref_offset_time_for_gfl, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% plot(ax3, reactive_power_ref_offset_time_for_gfl, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2);
% xline(ax3, q_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax3, "on");
% hold(ax3, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(q_ref_tracking_start_time:x_tick_division:q_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.5:0.5:1.5));
% xlim(ax3, [q_ref_tracking_start_time q_ref_tracking_start_time+end_time]);
% ylim(ax3, [-1.5 1.5]);
% title('Reactive power reference tracking', 'Interpreter', 'latex', 'FontSize', 12);
% 
% ax4 = axes(t);
% ax4.Layout.Tile = 4;
% hold(ax4, "on");
% plot(ax4, p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax4, q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
% plot(ax4, active_power_ref_offset_time_for_gfl, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% plot(ax4, reactive_power_ref_offset_time_for_gfl, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2);
% xline(ax4, disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax4, "on");
% legend('$p_c$', '$q_c$', '$p_{c,ref}$', '$q_{c,ref}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax4, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.5:1.5:1.5));
% xlim(ax4, [disconnection_start_time disconnection_start_time+end_time]);
% ylim(ax4, [-1.5 1.5]);
% title('Islanded mode (single converter)', 'Interpreter', 'latex', 'FontSize', 12);
% 
% linkaxes([ax1 ax2 ax3 ax4], 'y');
% 
% ax5 = axes(t);
% ax5.Layout.Tile = 5;
% hold(ax5, "on");
% plot(ax5, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax5, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
% xline(connection_time, 'LineStyle', '--', 'LineWidth',1.2);
% grid(ax5, "on");
% ylabel('Current (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
% hold(ax5, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim([connection_start_time connection_start_time+end_time]);
% ylim([-1 1]);
% 
% ax6 = axes(t);
% ax6.Layout.Tile = 6;
% hold(ax6, "on");
% plot(ax6, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax6, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
% xline(ax6, p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax6, "on");
% hold(ax6, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim(ax6, [p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim(ax6, [-1 1]);
% 
% ax7 = axes(t);
% ax7.Layout.Tile = 7;
% hold(ax7, "on");
% plot(ax7, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax7, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
% xline(ax7, q_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax7, "on");
% hold(ax7, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(q_ref_tracking_start_time:x_tick_division:q_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim(ax7, [q_ref_tracking_start_time q_ref_tracking_start_time+end_time]);
% ylim(ax7, [-1 1]);
% 
% ax8 = axes(t);
% ax8.Layout.Tile = 8;
% hold(ax8, "on");
% plot(ax8, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax8, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
% xline(ax8, disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax8, "on");
% legend('$i_{cd}$', '$i_{cq}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax8, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-0.5:0.5:0.5));
% xlim(ax8, [disconnection_start_time disconnection_start_time+end_time]);
% ylim(ax8, [-1 1]);
% 
% linkaxes([ax5 ax6 ax7 ax8], 'y');

% ax9 = axes(t);
% ax9.Layout.Tile = 9;
% hold(ax9, "on");
% plot(ax9, theta_g.time, theta_g.data .* 180/pi, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax9, theta_g.time, theta_g.data .* 180/pi, 'Color', 'r', 'LineWidth', 1.2, 'LineStyle','--');
% xline(connection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax9, "on");
% ylabel('Angle (deg)', 'Interpreter', 'latex', 'FontSize', 12);
% hold(ax9, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-180:90:180));
% xlim([connection_start_time connection_start_time+end_time]);
% ylim([-200 200]);
% 
% ax10 = axes(t);
% ax10.Layout.Tile = 10;
% hold(ax10, "on");
% plot(ax10, theta_g.time, theta_g.data .* 180/pi, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax10, theta_g.time, theta_g.data .* 180/pi, 'Color', 'r', 'LineWidth', 1.2, 'LineStyle','--');
% xline(p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax10, "on");
% hold(ax10, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-180:90:180));
% xlim([p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim([-200 200]);
% 
% ax11 = axes(t);
% ax11.Layout.Tile = 11;
% hold(ax11, "on");
% plot(ax11, theta_g.time, theta_g.data .* 180/pi, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax11, theta_g.time, theta_g.data .* 180/pi, 'Color', 'r', 'LineWidth', 1.2, 'LineStyle','--');
% xline(q_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax11, "on");
% hold(ax11, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(q_ref_tracking_start_time:x_tick_division:q_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-180:90:180));
% xlim([q_ref_tracking_start_time q_ref_tracking_start_time+end_time]);
% ylim([-200 200]);
% 
% ax12 = axes(t);
% ax12.Layout.Tile = 12;
% hold(ax12, "on");
% plot(ax12, theta_g.time, theta_g.data .* 180/pi, 'Color', 'b', 'LineWidth', 1.2);
% plot(ax12, theta_g.time, theta_g.data .* 180/pi, 'Color', 'r', 'LineWidth', 1.2, 'LineStyle','--');
% xline(disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax12, "on");
% legend('$\vartheta_{g}$', '$\vartheta_{c}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax12, "off");
% h = gca;
% h.XAxis.Visible = 'off';
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-180:90:180));
% xlim([disconnection_start_time disconnection_start_time+end_time]);
% ylim([-200 200]);

% linkaxes([ax9 ax10 ax11 ax12], 'y');

% ax9 = axes(t);
% ax9.Layout.Tile = 9;
% hold(ax9, "on");
% plot(ax9, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax9, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
% plot(ax9, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
% xline(connection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax9, "on");
% hold(ax9, "off");
% set(gca,'XTick',(connection_start_time:x_tick_division:connection_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.0:0.5:1.0));
% ylabel(ax9, 'Voltage (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
% xlim([connection_start_time connection_start_time+end_time]);
% ylim([-1.5 1.5]);
% 
% ax10 = axes(t);
% ax10.Layout.Tile = 10;
% hold(ax10, "on");
% plot(ax10, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax10, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
% plot(ax10, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
% xline(p_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax10, "on");
% hold(ax10, "off");
% h = gca;
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(p_ref_tracking_start_time:x_tick_division:p_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.0:0.5:1.0));
% xlim([p_ref_tracking_start_time p_ref_tracking_start_time+end_time]);
% ylim([-1.5 1.5]);
% 
% ax11 = axes(t);
% ax11.Layout.Tile = 11;
% hold(ax11, "on");
% plot(ax11, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax11, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
% plot(ax11, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
% xline(q_ref_tracking_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax11, "on");
% hold(ax11, "off");
% h = gca;
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(q_ref_tracking_start_time:x_tick_division:q_ref_tracking_start_time+end_time));
% xtickformat('%.2f');
% set(gca,'YTick',(-1.0:0.5:1.0));
% xlim([q_ref_tracking_start_time q_ref_tracking_start_time+end_time]);
% ylim([-1.5 1.5]);
% 
% ax12 = axes(t);
% ax12.Layout.Tile = 12;
% hold(ax12, "on");
% plot(ax12, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
% plot(ax12, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
% plot(ax12, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
% xline(disconnection_time, 'LineStyle','--', 'LineWidth',1.2);
% grid(ax12, "on");
% legend(ax12, '$u_g^a$', '$u_g^b$', '$u_g^c$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
% hold(ax12, "off");
% h = gca;
% h.YAxis.Visible = 'off';
% set(gca,'XTick',(disconnection_start_time:x_tick_division:disconnection_start_time+end_time));
% set(gca,'YTick',(-1.0:0.5:1.0));
% xlim([disconnection_start_time disconnection_start_time+end_time]);
% xtickformat('%.2f');
% ylim([-1.5 1.5]);
% 
% linkaxes([ax9 ax10 ax11 ax12], 'y');
% 
% xlabel(t, 'Time (s)', 'Interpreter', 'latex', 'FontSize', 8);

%% Grid fault plots
t = tiledlayout(3, 2, 'TileSpacing', 'tight', 'Padding', 'tight');

ax1 = axes(t);
ax1.Layout.Tile = 1;
hold(ax1, "on");
plot(ax1, p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
plot(ax1, q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
plot(ax1, active_power_ref_offset_time_for_gfl, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
plot(ax1, reactive_power_ref_offset_time_for_gfl, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2);
xline(ax1, grid_fault_volt_change_time, 'LineStyle','--', 'LineWidth',1.2);
grid(ax1, "on");
ylabel('Power (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
hold(ax1, "off");
h = gca;
h.XAxis.Visible = 'off';
set(gca,'XTick',(grid_fault_volt_time:x_tick_division:grid_fault_volt_time+end_time));
xtickformat('%.2f');
set(gca,'YTick',(-0.5:0.5:0.5));
xlim(ax1, [grid_fault_volt_time grid_fault_volt_time+end_time]);
ylim(ax1, [-0.75 0.75]);
title('Grid voltage drop', 'Interpreter', 'latex', 'FontSize', 12);

ax2 = axes(t);
ax2.Layout.Tile = 2;
hold(ax2, "on");
plot(ax2, p_c2.time, p_c2.data./s_N, 'Color', 'b', 'LineWidth', 1.2);
plot(ax2, q_c2.time, q_c2.data./s_N, 'Color', 'r', 'LineWidth', 1.2);
plot(ax2, active_power_ref_offset_time_for_gfl, double(p_c2_ref.data)./s_N, 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
plot(ax2, reactive_power_ref_offset_time_for_gfl, double(q_c2_ref.data)./s_N, 'Color', [0 0.8 0.8], 'LineStyle','--', 'LineWidth', 1.2);
xline(ax2, grid_fault_freq_change_time, 'LineStyle','--', 'LineWidth', 1.2);
grid(ax2, "on");
hold(ax2, "off");
h = gca;
h.XAxis.Visible = 'off';
h.YAxis.Visible = 'off';
set(gca,'XTick',(grid_fault_freq_time:x_tick_division:grid_fault_freq_time+end_time));
xtickformat('%.2f');
set(gca,'YTick',(-0.5:0.5:0.5));
xlim(ax2, [grid_fault_freq_time grid_fault_freq_time+end_time]);
ylim(ax2, [-0.75 0.75]);
legend(ax2, '$p_c$', '$q_c$', '$p_{c,ref}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');
title('Grid frequency drop', 'Interpreter', 'latex', 'FontSize', 12);

linkaxes([ax1 ax2], 'y');

ax3 = axes(t);
ax3.Layout.Tile = 3;
hold(ax3, "on");
plot(ax3, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
plot(ax3, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
xline(ax3, grid_fault_volt_change_time, 'LineStyle', '--', 'LineWidth',1.2);
grid(ax3, "on");
ylabel('Current (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
hold(ax3, "off");
h = gca;
h.XAxis.Visible = 'off';
set(gca,'XTick',(grid_fault_volt_time:x_tick_division:grid_fault_volt_time+end_time));
xtickformat('%.2f');
set(gca,'YTick',(-0.5:0.5:0.5));
xlim([grid_fault_volt_time grid_fault_volt_time+end_time]);
ylim([-1 1]);

ax4 = axes(t);
ax4.Layout.Tile = 4;
hold(ax4, "on");
plot(ax4, i_c2.time, i_c2_d./i_N, 'Color', 'b', 'LineWidth', 1.2);
plot(ax4, i_c2.time, i_c2_q./i_N, 'Color', 'r', 'LineWidth', 1.2);
xline(ax4, grid_fault_freq_change_time, 'LineStyle','--', 'LineWidth',1.2);
grid(ax4, "on");
hold(ax4, "off");
h = gca;
h.XAxis.Visible = 'off';
h.YAxis.Visible = 'off';
set(gca,'XTick',(grid_fault_freq_time:x_tick_division:grid_fault_freq_time+end_time));
xtickformat('%.2f');
set(gca,'YTick',(-0.5:0.5:0.5));
xlim(ax4, [grid_fault_freq_time grid_fault_freq_time+end_time]);
ylim(ax4, [-1 1]);
legend(ax4, '$i_{cd}$', '$i_{cq}$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');

linkaxes([ax3 ax4], 'y');

ax5 = axes(t);
ax5.Layout.Tile = 5;
hold(ax5, "on");
plot(ax5, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax5, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax5, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
xline(ax5, grid_fault_volt_change_time, 'LineStyle','--', 'LineWidth',1.2);
grid(ax5, "on");
hold(ax5, "off");
set(gca,'XTick',(grid_fault_volt_time:x_tick_division:grid_fault_volt_time+end_time));
xtickformat('%.2f');
set(gca,'YTick',(-1.0:0.5:1.0));
ylabel(ax5, 'Voltage (p.u.)', 'Interpreter', 'latex', 'FontSize', 12);
xlim([grid_fault_volt_time grid_fault_volt_time+end_time]);
ylim([-1.5 1.5]);

ax6 = axes(t);
ax6.Layout.Tile = 6;
hold(ax6, "on");
plot(ax6, u_pcc.time, u_pcc_a./u_N, 'Color', 'r', 'LineWidth', 1.2)
plot(ax6, u_pcc.time, u_pcc_b./u_N, 'Color', [0 0.6 0], 'LineWidth', 1.2)
plot(ax6, u_pcc.time, u_pcc_c./u_N, 'Color', 'b', 'LineWidth', 1.2);
xline(ax6, grid_fault_freq_change_time, 'LineStyle','--', 'LineWidth',1.2);
grid(ax6, "on");
hold(ax6, "off");
h = gca;
h.YAxis.Visible = 'off';
set(gca,'XTick',(grid_fault_freq_time:x_tick_division:grid_fault_freq_time+end_time));
xtickformat('%.2f');
set(gca,'YTick',(-1.0:0.5:1.0));
xlim([grid_fault_freq_time grid_fault_freq_time+end_time]);
ylim([-1.5 1.5]);
legend(ax6, '$u_g^a$', '$u_g^b$', '$u_g^c$', 'Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12, 'Orientation', 'Horizontal');

linkaxes([ax5 ax6], 'y');

xlabel(t, 'Time (s)', 'Interpreter', 'latex', 'FontSize', 12);

% % Time finder
% hold on;
% plot(p_c2.time, p_c2.data);
% %plot(q_c2.time, q_c2.data);
% plot(theta_g.time, theta_g.data);
% plot(p_c2_ref.time, double(p_c2_ref.data), 'Color', [0 0.6 0], 'LineStyle','--', 'LineWidth', 1.2);
% %plot(q_c2_ref.time, double(q_c2_ref.data), 'Color', [0.6 0 0], 'LineStyle','--', 'LineWidth', 1.2);
% hold off;