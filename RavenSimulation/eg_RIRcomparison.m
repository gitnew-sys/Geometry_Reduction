close all;
clear;
load('eg_0001_pan.mat'); %ModelE
a = mono_ir;
t1 = T2;
ta1 = T;

load('eg_0001_ab.mat'); %ModelE3
b = mono_ir;
t2 = T2;
tb2 = T;

load('eg_001_pan.mat'); %ModelD
c = mono_ir;
t3 = T2;
tc3 = T;

load('eg_001_ab.mat'); %ModelD3
d = mono_ir;
t4 = T2;
td4 = T;

load('eg_01_pan.mat');%ModelC
e = mono_ir;
t5 = T2;
te5 = T;

load('eg_01_ab.mat'); %ModelC3
f = mono_ir;
t6 = T2;
tf6 = T;

load('eg_reference.mat'); %ModelF
g= mono_ir;
t7 = T2;
tg7 = T;
%% RIRs of rece0
RIRs = ita_merge(a(1),b(1),c(1),d(1),e(1),f(1),e(1));
figure1 = ita_plot_time(RIRs,'axis',[0 0.2 -0.005 0.01]);

figure1.Children(13).Children(9).Color=[0.4940 0.1840 0.5560];                       % ModelE
figure1.Children(13).Children(8).Color=[0.4940 0.1840 0.5560];                       % ModelE3
figure1.Children(13).Children(7).Color=[0.9290 0.6940 0.1250];             % ModelD
figure1.Children(13).Children(6).Color=[0.9290 0.6940 0.1250];             % ModelD3
figure1.Children(13).Children(5).Color=[0.8500 0.3250 0.0980];        % ModelC
figure1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];        % ModelC3
figure1.Children(13).Children(3).Color=[0 0 0];                       % Model Reference

hold on
legend('ModelE Recevier0','ModelE3 Recevier0','ModelD Recevier0','ModelD3 Recevier0','ModelC Recevier0','ModelC3 Recevier0','ModelF Recevier0')


%% RIRs of rece1
RIRs = ita_merge(a(2),b(2),c(2),d(2),e(2),f(2),e(2));
figure1 = ita_plot_time(RIRs,'axis',[0 0.2 -0.005 0.01]);

figure1.Children(13).Children(9).Color=[0.4940 0.1840 0.5560];                       % ModelE
figure1.Children(13).Children(8).Color=[0.4940 0.1840 0.5560];                       % ModelE3
figure1.Children(13).Children(7).Color=[0.9290 0.6940 0.1250];             % ModelD
figure1.Children(13).Children(6).Color=[0.9290 0.6940 0.1250];             % ModelD3
figure1.Children(13).Children(5).Color=[0.8500 0.3250 0.0980];        % ModelC
figure1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];        % ModelC3
figure1.Children(13).Children(3).Color=[0 0 0];                       % Model Reference

hold on
legend('ModelE Recevier1','ModelE3 Recevier1','ModelD Recevier1','ModelD3 Recevier1','ModelC Recevier1','ModelC3 Recevier1','ModelF Recevier1')

%% Merge audios
AllRIRs = ita_merge(a(1),a(2),b(1),b(2),c(1),c(2),d(1),d(2),e(1),e(2),f(1),f(2),e(1),e(2));%change bianliang later
% Windowed = ita_time_window(AllRIRs,[0,1.5])

%% Smooth audios in Frequency domain
SmoothedRIRs = ita_smooth_frequency(AllRIRs,'bandwidth',1/1);
% Plot RIRs in Frequency domain
fig1 = ita_plot_freq(SmoothedRIRs,'axis',[20 20000 -30 -8],'LineWidth',2); % set color of last line of plot. if itaAudioObj has multiple channels, 
% the index increases for other channels

fig1.Children(13).Children(16).Color=[0 0 0];  % ModelE R_0   black
fig1.Children(13).Children(15).Color=[0 0 0];  % ModelE R_1

fig1.Children(13).Children(14).Color=[0 0 0];  % ModelE R_0   black
fig1.Children(13).Children(13).Color=[0 0 0];  % ModelE R_1
fig1.Children(13).Children(12).Color=[0 0.4470 0.7410];  % ModelE3 R_0   blue
fig1.Children(13).Children(11).Color=[0 0.4470 0.7410];  % ModelE3 R_1
fig1.Children(13).Children(10).Color=[0.8500 0.3250 0.0980]; % ModelD R_0    red
fig1.Children(13).Children(9).Color=[0.8500 0.3250 0.0980];  % ModelD R_1 
fig1.Children(13).Children(8).Color=[0.9290 0.6940 0.1250];  % ModelD3 R_0   orange
fig1.Children(13).Children(7).Color=[0.9290 0.6940 0.1250];  % ModelD3 R_1
fig1.Children(13).Children(6).Color=[0.4660 0.6740 0.1880];  % ModelC R_0   green
fig1.Children(13).Children(5).Color=[0.4660 0.6740 0.1880];  % ModelC R_1
fig1.Children(13).Children(4).Color=[0.4940 0.1840 0.5560];   % ModelC3 R_0   purple
fig1.Children(13).Children(3).Color=[0.4940 0.1840 0.5560];   % ModelC3 R_1  

fig1.Children(13).Children(16).LineStyle='-';
fig1.Children(13).Children(15).LineStyle=':';
fig1.Children(13).Children(14).LineStyle='-';
fig1.Children(13).Children(13).LineStyle=':';
fig1.Children(13).Children(12).LineStyle='-';
fig1.Children(13).Children(11).LineStyle=':';
fig1.Children(13).Children(10).LineStyle='-';
fig1.Children(13).Children(9).LineStyle=':';
fig1.Children(13).Children(8).LineStyle='-';
fig1.Children(13).Children(7).LineStyle=':';
fig1.Children(13).Children(6).LineStyle='-';
fig1.Children(13).Children(5).LineStyle=':';
fig1.Children(13).Children(4).LineStyle='-';
fig1.Children(13).Children(3).LineStyle=':';

hold on
legend('ModelE Recevier0','ModelE Recevier1','ModelE3 Recevier0','ModelE3 Recevier1','ModelD Recevier0','ModelD Recevier1','ModelD3 Recevier0','ModelD3 Recevier1','ModelC Recevier0','ModelC Recevier1','ModelC3 Recevier0','ModelC3 Recevier1','ModelF Recevier0','ModelF Recevier1')


%% receiver 0 frequency responses

AllRIRs = ita_merge(a(1),b(1),c(1),d(1),e(1),f(1),g(1));
SmoothedRIRs = ita_smooth_frequency(AllRIRs,'bandwidth',1/1);

fig1 = ita_plot_freq(SmoothedRIRs,'axis',[20 20000 -30 -8],'LineWidth',2); % set color of last line of plot. if itaAudioObj has multiple channels, 

fig1.Children(13).Children(9).Color=[0.4940 0.1840 0.5560];                       % ModelE
fig1.Children(13).Children(8).Color=[0.4940 0.1840 0.5560];                       % ModelE3
fig1.Children(13).Children(7).Color=[0.9290 0.6940 0.1250];             % ModelD
fig1.Children(13).Children(6).Color=[0.9290 0.6940 0.1250];             % ModelD3
fig1.Children(13).Children(5).Color=[0.8500 0.3250 0.0980];        % ModelC
fig1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];        % ModelC3
fig1.Children(13).Children(3).Color=[0 0 0];                       % Model Reference

fig1.Children(13).Children(8).LineStyle=':';
fig1.Children(13).Children(6).LineStyle=':';
fig1.Children(13).Children(4).LineStyle=':';

hold on
legend('ModelE Recevier0','ModelE3 Recevier0','ModelD Recevier0','ModelD3 Recevier0','ModelC Recevier0','ModelC3 Recevier0','ModelF Recevier0')

%% receiver 1 frequency responses

AllRIRs = ita_merge(a(2),b(2),c(2),d(2),e(2),f(2),g(2));
SmoothedRIRs = ita_smooth_frequency(AllRIRs,'bandwidth',1/1);

fig1 = ita_plot_freq(SmoothedRIRs,'axis',[20 20000 -30 -8],'LineWidth',2); % set color of last line of plot. if itaAudioObj has multiple channels, 

fig1.Children(13).Children(9).Color=[0.4940 0.1840 0.5560];                       % ModelE
fig1.Children(13).Children(8).Color=[0.4940 0.1840 0.5560];                       % ModelE3
fi1.Children(13).Children(7).Color=[0.9290 0.6940 0.1250];             % ModelD
fig1.Children(13).Children(6).Color=[0.9290 0.6940 0.1250];             % ModelD3
fig1.Children(13).Children(5).Color=[0.8500 0.3250 0.0980];        % ModelC
fig1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];        % ModelC3
fig1.Children(13).Children(3).Color=[0 0 0];                       % Model Reference

fig1.Children(13).Children(8).LineStyle=':';
fig1.Children(13).Children(6).LineStyle=':';
fig1.Children(13).Children(4).LineStyle=':';

hold on
legend('ModelE Recevier1','ModelE3 Recevier1','ModelD Recevier1','ModelD3 Recevier1','ModelC Recevier1','ModelC3 Recevier1','ModelF Recevier1')



%% EDC of receiver0


EDCa = ita_roomacoustics_EDC(a(1),'method','noCut');
EDCb = ita_roomacoustics_EDC(b(1),'method','noCut');
EDCc = ita_roomacoustics_EDC(c(1),'method','noCut');
EDCd = ita_roomacoustics_EDC(d(1),'method','noCut');
EDCe = ita_roomacoustics_EDC(e(1),'method','noCut');
EDCf = ita_roomacoustics_EDC(f(1),'method','noCut');
EDCg = ita_roomacoustics_EDC(g(1),'method','noCut');
EDCALL = ita_merge(EDCa,EDCb,EDCc,EDCd,EDCe,EDCf,EDCg);
% %% Plot RIRs in Time domain
% 
fig2 = ita_plot_time_dB(EDCALL,'axis',[0 2.5 -80 0],'LineWidth',2); 

fig2.Children(13).Children(9).Color=[0.4940 0.1840 0.5560];                       % ModelE
fig2.Children(13).Children(8).Color=[0.4940 0.1840 0.5560];                       % ModelE3
fig2.Children(13).Children(7).Color=[0.9290 0.6940 0.1250];             % ModelD
fig2.Children(13).Children(6).Color=[0.9290 0.6940 0.1250];             % ModelD3
fig2.Children(13).Children(5).Color=[0.8500 0.3250 0.0980];        % ModelC
fig2.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];        % ModelC3
fig2.Children(13).Children(3).Color=[0 0 0];                       % Model Reference

fig2.Children(13).Children(8).LineStyle=':';
fig2.Children(13).Children(6).LineStyle=':';
fig2.Children(13).Children(4).LineStyle=':';

hold on
legend('ModelE Recevier0','ModelE3 Recevier0','ModelD Recevier0','ModelD3 Recevier0','ModelC Recevier0','ModelC3 Recevier0','ModelF Recevier0')

%% EDC of receiver1
EDCa = ita_roomacoustics_EDC(a(2),'method','noCut');
EDCb = ita_roomacoustics_EDC(b(2),'method','noCut');
EDCc = ita_roomacoustics_EDC(c(2),'method','noCut');
EDCd = ita_roomacoustics_EDC(d(2),'method','noCut');
EDCe = ita_roomacoustics_EDC(e(2),'method','noCut');
EDCf = ita_roomacoustics_EDC(f(2),'method','noCut');
EDCg = ita_roomacoustics_EDC(g(2),'method','noCut');
EDCALL = ita_merge(EDCa,EDCb,EDCc,EDCd,EDCe,EDCf,EDCg);
fig2 = ita_plot_time_dB(EDCALL,'axis',[0 2.5 -80 0],'LineWidth',2); 

fig2.Children(13).Children(9).Color=[0.4940 0.1840 0.5560];                       % ModelE
fig2.Children(13).Children(8).Color=[0.4940 0.1840 0.5560];                       % ModelE3
fig2.Children(13).Children(7).Color=[0.9290 0.6940 0.1250];             % ModelD
fig2.Children(13).Children(6).Color=[0.9290 0.6940 0.1250];             % ModelD3
fig2.Children(13).Children(5).Color=[0.8500 0.3250 0.0980];        % ModelC
fig2.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];        % ModelC3
fig2.Children(13).Children(3).Color=[0 0 0];                       % Model Reference

fig2.Children(13).Children(8).LineStyle=':';
fig2.Children(13).Children(6).LineStyle=':';
fig2.Children(13).Children(4).LineStyle=':';

hold on
legend('ModelE Recevier1','ModelE3 Recevier1','ModelD Recevier1','ModelD3 Recevier1','ModelC Recevier1','ModelC3 Recevier1','ModelF Recevier1')



%% Plot Revertime r0
figure;
x = [1 2 3 4 5 6 7];
y1 = [ta1.reverbTime(3) tb2.reverbTime(3) tc3.reverbTime(3) td4.reverbTime(3) te5.reverbTime(3) tf6.reverbTime(3) tg7.reverbTime(3)];
y2 = [ta1.reverbTime(4) tb2.reverbTime(4) tc3.reverbTime(4) td4.reverbTime(4) te5.reverbTime(4) tf6.reverbTime(4) tg7.reverbTime(4)];
y3 = [ta1.reverbTime(5) tb2.reverbTime(5) tc3.reverbTime(5) td4.reverbTime(5) te5.reverbTime(5) tf6.reverbTime(5) tg7.reverbTime(5)];
y4 = [ta1.reverbTime(6) tb2.reverbTime(6) tc3.reverbTime(6) td4.reverbTime(6) te5.reverbTime(6) tf6.reverbTime(6) tg7.reverbTime(6)];
y5 = [ta1.reverbTime(7) tb2.reverbTime(7) tc3.reverbTime(7) td4.reverbTime(7) te5.reverbTime(7) tf6.reverbTime(7) tg7.reverbTime(7)];
y6 = [ta1.reverbTime(8) tb2.reverbTime(8) tc3.reverbTime(8) td4.reverbTime(8) te5.reverbTime(8) tf6.reverbTime(8) tg7.reverbTime(8)];


plot(x,y1,'-o','Color',[0 0.4470 0.7410]); %shen lan
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]); % ju hong
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]); %lv
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);% xue hong
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('RT60');
%% Plot Revertime r1
figure; 
x = [1 2 3 4 5 6 7];
y1 = [t1.reverbTime(3) t2.reverbTime(3) t3.reverbTime(3) t4.reverbTime(3) t5.reverbTime(3) t6.reverbTime(3) t7.reverbTime(3)];
y2 = [t1.reverbTime(4) t2.reverbTime(4) t3.reverbTime(4) t4.reverbTime(4) t5.reverbTime(4) t6.reverbTime(4) t7.reverbTime(4)];
y3 = [t1.reverbTime(5) t2.reverbTime(5) t3.reverbTime(5) t4.reverbTime(5) t5.reverbTime(5) t6.reverbTime(5) t7.reverbTime(5)];
y4 = [t1.reverbTime(6) t2.reverbTime(6) t3.reverbTime(6) t4.reverbTime(6) t5.reverbTime(6) t6.reverbTime(6) t7.reverbTime(6)];
y5 = [t1.reverbTime(7) t2.reverbTime(7) t3.reverbTime(7) t4.reverbTime(7) t5.reverbTime(7) t6.reverbTime(7) t7.reverbTime(7)];
y6 = [t1.reverbTime(8) t2.reverbTime(8) t3.reverbTime(8) t4.reverbTime(8) t5.reverbTime(8) t6.reverbTime(8) t7.reverbTime(8)];


plot(x,y1,'-o','Color',[0 0.4470 0.7410]); %shen lan
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]); % ju hong
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]); %lv
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);% xue hong
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('RT60');
%% plot C80 r0
figure;
x = [1 2 3 4 5 6 7];
y1 = [ta1.C80(3) tb2.C80(3) tc3.C80(3) td4.C80(3) te5.C80(3) tf6.C80(3) tg7.C80(3)];
y2 = [ta1.C80(4) tb2.C80(4) tc3.C80(4) td4.C80(4) te5.C80(4) tf6.C80(4) tg7.C80(4)];
y3 = [ta1.C80(5) tb2.C80(5) tc3.C80(5) td4.C80(5) te5.C80(5) tf6.C80(5) tg7.C80(5)];
y4 = [ta1.C80(6) tb2.C80(6) tc3.C80(6) td4.C80(6) te5.C80(6) tf6.C80(6) tg7.C80(6)];
y5 = [ta1.C80(7) tb2.C80(7) tc3.C80(7) td4.C80(7) te5.C80(7) tf6.C80(7) tg7.C80(7)];
y6 = [ta1.C80(8) tb2.C80(8) tc3.C80(8) td4.C80(8) te5.C80(8) tf6.C80(8) tg7.C80(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('C80');
%% plot C80 r1
figure;
x = [1 2 3 4 5 6 7];
y1 = [t1.C80(3) t2.C80(3) t3.C80(3) t4.C80(3) t5.C80(3) t6.C80(3) t7.C80(3)];
y2 = [t1.C80(4) t2.C80(4) t3.C80(4) t4.C80(4) t5.C80(4) t6.C80(4) t7.C80(4)];
y3 = [t1.C80(5) t2.C80(5) t3.C80(5) t4.C80(5) t5.C80(5) t6.C80(5) t7.C80(5)];
y4 = [t1.C80(6) t2.C80(6) t3.C80(6) t4.C80(6) t5.C80(6) t6.C80(6) t7.C80(6)];
y5 = [t1.C80(7) t2.C80(7) t3.C80(7) t4.C80(7) t5.C80(7) t6.C80(7) t7.C80(7)];
y6 = [t1.C80(8) t2.C80(8) t3.C80(8) t4.C80(8) t5.C80(8) t6.C80(8) t7.C80(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('C80');
%% plot D50 r0
figure;
x = [1 2 3 4 5 6 7];
y1 = [ta1.D50(3) tb2.D50(3) tc3.D50(3) td4.D50(3) te5.D50(3) tf6.D50(3) tg7.D50(3)];
y2 = [ta1.D50(4) tb2.D50(4) tc3.D50(4) td4.D50(4) te5.D50(4) tf6.D50(4) tg7.D50(4)];
y3 = [ta1.D50(5) tb2.D50(5) tc3.D50(5) td4.D50(5) te5.D50(5) tf6.D50(5) tg7.D50(5)];
y4 = [ta1.D50(6) tb2.D50(6) tc3.D50(6) td4.D50(6) te5.D50(6) tf6.D50(6) tg7.D50(6)];
y5 = [ta1.D50(7) tb2.D50(7) tc3.D50(7) td4.D50(7) te5.D50(7) tf6.D50(7) tg7.D50(7)];
y6 = [ta1.D50(8) tb2.D50(8) tc3.D50(8) td4.D50(8) te5.D50(8) tf6.D50(8) tg7.D50(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('D50');
%% plot D50 r1
figure;
x = [1 2 3 4 5 6 7];
y1 = [t1.D50(3) t2.D50(3) t3.D50(3) t4.D50(3) t5.D50(3) t6.D50(3) t7.D50(3)];
y2 = [t1.D50(4) t2.D50(4) t3.D50(4) t4.D50(4) t5.D50(4) t6.D50(4) t7.D50(4)];
y3 = [t1.D50(5) t2.D50(5) t3.D50(5) t4.D50(5) t5.D50(5) t6.D50(5) t7.D50(5)];
y4 = [t1.D50(6) t2.D50(6) t3.D50(6) t4.D50(6) t5.D50(6) t6.D50(6) t7.D50(6)];
y5 = [t1.D50(7) t2.D50(7) t3.D50(7) t4.D50(7) t5.D50(7) t6.D50(7) t7.D50(7)];
y6 = [t1.D50(8) t2.D50(8) t3.D50(8) t4.D50(8) t5.D50(8) t6.D50(8) t7.D50(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('D50');
%% plot strength r0
figure;
x = [1 2 3 4 5 6 7];
y1 = [ta1.G(3) tb2.G(3) tc3.G(3) td4.G(3) te5.G(3) tf6.G(3) tg7.G(3)];
y2 = [ta1.G(4) tb2.G(4) tc3.G(4) td4.G(4) te5.G(4) tf6.G(4) tg7.G(4)];
y3 = [ta1.G(5) tb2.G(5) tc3.G(5) td4.G(5) te5.G(5) tf6.G(5) tg7.G(5)];
y4 = [ta1.G(6) tb2.G(6) tc3.G(6) td4.G(6) te5.G(6) tf6.G(6) tg7.G(6)];
y5 = [ta1.G(7) tb2.G(7) tc3.G(7) td4.G(7) te5.G(7) tf6.G(7) tg7.G(7)];
y6 = [ta1.G(8) tb2.G(8) tc3.G(8) td4.G(8) te5.G(8) tf6.G(8) tg7.G(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('Strength');

%% plot strength r1
figure;
x = [1 2 3 4 5 6 7];
y1 = [t1.G(3) t2.G(3) t3.G(3) t4.G(3) t5.G(3) t6.G(3) t7.G(3)];
y2 = [t1.G(4) t2.G(4) t3.G(4) t4.G(4) t5.G(4) t6.G(4) t7.G(4)];
y3 = [t1.G(5) t2.G(5) t3.G(5) t4.G(5) t5.G(5) t6.G(5) t7.G(5)];
y4 = [t1.G(6) t2.G(6) t3.G(6) t4.G(6) t5.G(6) t6.G(6) t7.G(6)];
y5 = [t1.G(7) t2.G(7) t3.G(7) t4.G(7) t5.G(7) t6.G(7) t7.G(7)];
y6 = [t1.G(8) t2.G(8) t3.G(8) t4.G(8) t5.G(8) t6.G(8) t7.G(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('Strength');
%% plot EDT r0
figure;
x = [1 2 3 4 5 6 7];
y1 = [ta1.G(3) tb2.G(3) tc3.G(3) td4.G(3) te5.G(3) tf6.G(3) tg7.G(3)];
y2 = [ta1.G(4) tb2.G(4) tc3.G(4) td4.G(4) te5.G(4) tf6.G(4) tg7.G(4)];
y3 = [ta1.G(5) tb2.G(5) tc3.G(5) td4.G(5) te5.G(5) tf6.G(5) tg7.G(5)];
y4 = [ta1.G(6) tb2.G(6) tc3.G(6) td4.G(6) te5.G(6) tf6.G(6) tg7.G(6)];
y5 = [ta1.G(7) tb2.G(7) tc3.G(7) td4.G(7) te5.G(7) tf6.G(7) tg7.G(7)];
y6 = [ta1.G(8) tb2.G(8) tc3.G(8) td4.G(8) te5.G(8) tf6.G(8) tg7.G(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('EDT');

%% plot EDT r1
figure;
x = [1 2 3 4 5 6 7];
y1 = [t1.G(3) t2.G(3) t3.G(3) t4.G(3) t5.G(3) t6.G(3) t7.G(3)];
y2 = [t1.G(4) t2.G(4) t3.G(4) t4.G(4) t5.G(4) t6.G(4) t7.G(4)];
y3 = [t1.G(5) t2.G(5) t3.G(5) t4.G(5) t5.G(5) t6.G(5) t7.G(5)];
y4 = [t1.G(6) t2.G(6) t3.G(6) t4.G(6) t5.G(6) t6.G(6) t7.G(6)];
y5 = [t1.G(7) t2.G(7) t3.G(7) t4.G(7) t5.G(7) t6.G(7) t7.G(7)];
y6 = [t1.G(8) t2.G(8) t3.G(8) t4.G(8) t5.G(8) t6.G(8) t7.G(8)];

plot(x,y1,'-o','Color',[0 0.4470 0.7410]);
hold on 
plot(x,y2,'-+','Color',[0.8500 0.3250 0.0980]);
hold on 
plot(x,y3,'-*','Color',[0.4660 0.6740 0.1880]);
hold on 
plot(x,y4,'-x','Color',[0.6350 0.0780 0.1840]);
hold on
plot(x,y5,'-s','Color',[0.9290 0.6940 0.1250]); % huang
hold on 
plot(x,y6,'-^','Color',[0.4940 0.1840 0.5560]); % zi
legend('125HZ','250Hz','500HZ','1000Hz','2000HZ','4000HZ')
hold off
xticklabels({'ModelE','ModelE3','ModelD','ModelD3','ModelC','ModelC3','ModelF'})
title('EDT');
%% average parameters

% ModelE
Rece0.AvRT60 = mean(ta1.reverbTime);
Rece1.AvRT60 = mean(t1.reverbTime);
ModelA.AvRT60 = (Rece0.AvRT60 + Rece1.AvRT60)/2;


Rece0.AvC80 = mean(ta1.C80);
Rece1.AvC80 = mean(t1.C80);
ModelA.AvC80 = (Rece0.AvC80 + Rece1.AvC80)/2;

Rece0.AvD50 = mean(ta1.D50);
Rece1.AvD50 = mean(t1.D50);
ModelA.AvD50 = (Rece0.AvD50 + Rece1.AvD50)/2;

Rece0.AvG = mean(ta1.G);
Rece1.AvG = mean(t1.G);
ModelA.AvG = (Rece0.AvG + Rece1.AvG)/2;

Rece0.AvEDT = mean(ta1.EDT);
Rece1.AvEDT = mean(t1.EDT);
ModelA.AvEDT = (Rece0.AvEDT + Rece1.AvEDT)/2;


%% ModelE3
BRece0.AvRT60 = mean(tb2.reverbTime);
BRece1.AvRT60 = mean(t2.reverbTime);
ModelB.AvRT60 = (BRece0.AvRT60 + BRece1.AvRT60)/2;


BRece0.AvC80 = mean(tb2.C80);
BRece1.AvC80 = mean(t2.C80);
ModelB.AvC80 = (BRece0.AvC80 + BRece1.AvC80)/2;

BRece0.AvD50 = mean(tb2.D50);
BRece1.AvD50 = mean(t2.D50);
ModelB.AvD50 = (BRece0.AvD50 + BRece1.AvD50)/2;

BRece0.AvG = mean(tb2.G);
BRece1.AvG = mean(t2.G);
ModelB.AvG = (BRece0.AvG + BRece1.AvG)/2;

BRece0.AvEDT = mean(tb2.EDT);
BRece1.AvEDT = mean(t2.EDT);
ModelB.AvEDT = (BRece0.AvEDT + BRece1.AvEDT)/2;


%% ModelD
B2Rece0.AvRT60 = mean(tc3.reverbTime);
B2Rece1.AvRT60 = mean(t3.reverbTime);
ModelB2.AvRT60 = (B2Rece0.AvRT60 + B2Rece1.AvRT60)/2;


B2Rece0.AvC80 = mean(tc3.C80);
B2Rece1.AvC80 = mean(t3.C80);
ModelB2.AvC80 = (B2Rece0.AvC80 + B2Rece1.AvC80)/2;

B2Rece0.AvD50 = mean(tc3.D50);
B2Rece1.AvD50 = mean(t3.D50);
ModelB2.AvD50 = (B2Rece0.AvD50 + B2Rece1.AvD50)/2;

B2Rece0.AvG = mean(tc3.G);
B2Rece1.AvG = mean(t3.G);
ModelB2.AvG = (B2Rece0.AvG + B2Rece1.AvG)/2;

B2Rece0.AvEDT = mean(tc3.EDT);
B2Rece1.AvEDT = mean(t3.EDT);
ModelB2.AvEDT = (B2Rece0.AvEDT + B2Rece1.AvEDT)/2;

%% ModelD3

CRece0.AvRT60 = mean(td4.reverbTime);
CRece1.AvRT60 = mean(t4.reverbTime);
ModelC.AvRT60 = (CRece0.AvRT60 + CRece1.AvRT60)/2;


CRece0.AvC80 = mean(td4.C80);
CRece1.AvC80 = mean(t4.C80);
ModelC.AvC80 = (CRece0.AvC80 + CRece1.AvC80)/2;

CRece0.AvD50 = mean(td4.D50);
CRece1.AvD50 = mean(t4.D50);
ModelC.AvD50 = (CRece0.AvD50 + CRece1.AvD50)/2;

CRece0.AvG = mean(td4.G);
CRece1.AvG = mean(t4.G);
ModelC.AvG = (CRece0.AvG + CRece1.AvG)/2;

CRece0.AvEDT = mean(td4.EDT);
CRece1.AvEDT = mean(t4.EDT);
ModelC.AvEDT = (CRece0.AvEDT + CRece1.AvEDT)/2;

%% ModelC

C2Rece0.AvRT60 = mean(te5.reverbTime);
C2Rece1.AvRT60 = mean(t5.reverbTime);
ModelC2.AvRT60 = (C2Rece0.AvRT60 + C2Rece1.AvRT60)/2;


C2Rece0.AvC80 = mean(te5.C80);
C2Rece1.AvC80 = mean(t5.C80);
ModelC2.AvC80 = (C2Rece0.AvC80 + C2Rece1.AvC80)/2;

C2Rece0.AvD50 = mean(te5.D50);
C2Rece1.AvD50 = mean(t5.D50);
ModelC2.AvD50 = (C2Rece0.AvD50 + C2Rece1.AvD50)/2;

C2Rece0.AvG = mean(te5.G);
C2Rece1.AvG = mean(t5.G);
ModelC2.AvG = (C2Rece0.AvG + C2Rece1.AvG)/2;

C2Rece0.AvEDT = mean(te5.EDT);
C2Rece1.AvEDT = mean(t5.EDT);
ModelC2.AvEDT = (C2Rece0.AvEDT + C2Rece1.AvEDT)/2;

%% ModelC3
DRece0.AvRT60 = mean(tf6.reverbTime);
DRece1.AvRT60 = mean(t6.reverbTime);
ModelD.AvRT60 = (DRece0.AvRT60 + DRece1.AvRT60)/2;

DRece0.AvC80 = mean(tf6.C80);
DRece1.AvC80 = mean(t6.C80);
ModelD.AvC80 = (DRece0.AvC80 + DRece1.AvC80)/2;

DRece0.AvD50 = mean(tf6.D50);
DRece1.AvD50 = mean(t6.D50);
ModelD.AvD50 = (DRece0.AvD50 +DRece1.AvD50)/2;

DRece0.AvG = mean(tf6.G);
DRece1.AvG = mean(t6.G);
ModelD.AvG = (DRece0.AvG + DRece1.AvG)/2;

DRece0.AvEDT = mean(tf6.EDT);
DRece1.AvEDT = mean(t6.EDT);
ModelD.AvEDT = (DRece0.AvEDT + DRece1.AvEDT)/2;

