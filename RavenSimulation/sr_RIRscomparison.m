close all;
clear;
load('sr_orig_pan.mat'); %D
a = mono_ir;
t1 = T2;
ta1 = T;

load('sr_orig_ab.mat'); %D3
b = mono_ir;
t2 = T2;
tb2 = T;

load('sr_5_pan.mat');%E
c = mono_ir;
t3 = T2;
tc3 = T;

load('sr_5_ab.mat'); %e3
d = mono_ir;
t4 = T2;
td4 = T;

%% RIRs of rece0
RIRs = ita_merge(a(1),b(1),c(1),d(1));
figure1 = ita_plot_time(RIRs,'axis',[0 0.5 -0.02 0.08]);

figure1.Children(13).Children(6).Color=[0 0 0];                  %orig_pan Receiver0
figure1.Children(13).Children(5).Color=[0 0.4470 0.7410];        %orig_ab Receiver0
figure1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];   %5_pan Receiver0
figure1.Children(13).Children(3).Color=[0.9290 0.6940 0.1250];   %5_ab Receiver1 

hold on
legend('ModelR Recevier0','ModelR3 Recevier0','ModelT Recevier0','ModelT3 Recevier0')



%% RIRs of rece1
RIRs = ita_merge(a(2),b(2),c(2),d(2));
figure1 = ita_plot_time(RIRs,'axis',[0 0.5 -0.02 0.08]);

figure1.Children(13).Children(6).Color=[0 0 0];                  %orig_pan Receiver1  black
figure1.Children(13).Children(5).Color=[0 0.4470 0.7410];        %orig_ab Receiver1  blue
figure1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980];   %5_pan Receiver1   red
figure1.Children(13).Children(3).Color=[0.9290 0.6940 0.1250];   %5_ab Receiver1    orange

hold on
legend('ModelR Recevier1','ModelR3 Recevier1','ModelT Recevier1','ModelT3 Recevier1')

%% Merge audios
AllRIRs = ita_merge(a(1),a(2),b(1),b(2),c(1),c(2),d(1),d(2)); %change bianliang later
% Windowed = ita_time_window(AllRIRs,[0,1.5])

%% Smooth audios in Frequency domain
SmoothedRIRs = ita_smooth_frequency(AllRIRs,'bandwidth',1/3);
%% Plot RIRs in Frequency domain
fig1 = ita_plot_freq(SmoothedRIRs,'axis',[10 30000 -30 7],'LineWidth',2);  % set color of last line of plot. if itaAudioObj has multiple channels, 
% the index increases for other channels
fig1.Children(13).Children(10).Color=[0 0 0]; %  orig_pan Receiver0    black
fig1.Children(13).Children(9).Color=[0 0 0]; %  orig_pan Receiver1    black
fig1.Children(13).Children(8).Color=[0 0.4470 0.7410]; % orig_ab Receiver0     blue
fig1.Children(13).Children(7).Color=[0 0.4470 0.7410]; % orig_ab Receiver1     blue
fig1.Children(13).Children(6).Color=[0.8500 0.3250 0.0980]; % 5_pan Receiver0    red
fig1.Children(13).Children(5).Color=[0.8500 0.3250 0.0980]; % 5_pan Receiver1    red
fig1.Children(13).Children(4).Color=[0.9290 0.6940 0.1250]; % 5_ab Receiver0    orange
fig1.Children(13).Children(3).Color=[0.9290 0.6940 0.1250]; % 5_ab Receiver1     orange

fig1.Children(13).Children(10).LineStyle='-';
fig1.Children(13).Children(9).LineStyle=':';
fig1.Children(13).Children(8).LineStyle='-';
fig1.Children(13).Children(7).LineStyle=':';
fig1.Children(13).Children(6).LineStyle='-';
fig1.Children(13).Children(5).LineStyle=':';
fig1.Children(13).Children(4).LineStyle='-';
fig1.Children(13).Children(3).LineStyle=':';

hold on
legend('ModelR Recevier0','ModelR Recevier1','ModelR3 Recevier0','ModelR3 Recevier1','ModelT Recevier0','ModelT Recevier1','ModelT3 Recevier0','ModelT3 Recevier1')


%% receiver 0 frequency responses

AllRIRs_r0 = ita_merge(a(1),b(1),c(1),d(1));
SmoothedRIRs = ita_smooth_frequency(AllRIRs_r0,'bandwidth',1/3);

fig1 = ita_plot_freq(SmoothedRIRs,'axis',[10 30000 -30 9],'LineWidth',2); % set color of last line of plot. if itaAudioObj has multiple channels, 

fig1.Children(13).Children(6).Color=[0 0 0];  % orig_pan Receiver0
fig1.Children(13).Children(5).Color=[0 0.4470 0.7410];  % orig_ab Receiver0
fig1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980]; % 5_pan Receiver0
fig1.Children(13).Children(3).Color=[0.9290 0.6940 0.1250]; % 5_ab Receiver0

hold on
legend('ModelR Recevier0','ModelR3 Recevier0','ModelT Recevier0','ModelT3 Recevier0')

%% receiver 1 frequency responses

AllRIRs_r1 = ita_merge(a(2),b(2),c(2),d(2));
SmoothedRIRs = ita_smooth_frequency(AllRIRs_r1,'bandwidth',1/3);

fig1 = ita_plot_freq(SmoothedRIRs,'axis',[10 30000 -30 9],'LineWidth',2); % set color of last line of plot. if itaAudioObj has multiple channels, 

fig1.Children(13).Children(6).Color=[0 0 0];  % orig_pan Receiver1
fig1.Children(13).Children(5).Color=[0 0.4470 0.7410];  % orig_ab Receiver1
fig1.Children(13).Children(4).Color=[0.8500 0.3250 0.0980]; % 5_pan Receiver1
fig1.Children(13).Children(3).Color=[0.9290 0.6940 0.1250]; % 5_ab Receiver1

hold on
legend('ModelR Recevier1','ModelR3 Recevier1','ModelT Recevier1','ModelT3 Recevier1')



%% EDC of receiver0
EDCa = ita_roomacoustics_EDC(a(1),'method','noCut');
EDCb = ita_roomacoustics_EDC(b(1),'method','noCut');
EDCc = ita_roomacoustics_EDC(c(1),'method','noCut');
EDCd = ita_roomacoustics_EDC(d(1),'method','noCut');
EDCALL = ita_merge(EDCa,EDCb,EDCc,EDCd);
% Plot RIRs in Time domain
fig2 = ita_plot_time_dB(EDCALL,'axis',[0 3 -130 5],'LineWidth',2); 
fig2.Children(13).Children(6).Color=[0 0 0];  % orig_pan Receiver0
fig2.Children(13).Children(5).Color=[0 0.4470 0.7410];  % orig_ab Receiver0
fig2.Children(13).Children(4).Color=[0.8500 0.3250 0.0980]; % 5_pan Receiver0
fig2.Children(13).Children(3).Color=[0.9290 0.6940 0.1250]; % 5_ab Receiver0

hold on
legend('ModelR Recevier0','ModelR3 Recevier0','ModelT Recevier0','ModelT3 Recevier0')

%% EDC of receiver1
EDCa = ita_roomacoustics_EDC(a(2),'method','noCut');
EDCb = ita_roomacoustics_EDC(b(2),'method','noCut');
EDCc = ita_roomacoustics_EDC(c(2),'method','noCut');
EDCd = ita_roomacoustics_EDC(d(2),'method','noCut');
EDCALL = ita_merge(EDCa,EDCb,EDCc,EDCd);
fig2 = ita_plot_time_dB(EDCALL,'axis',[0 3 -130 5],'LineWidth',2); 

fig2.Children(13).Children(6).Color=[0 0 0];  % orig_pan Receiver1
fig2.Children(13).Children(5).Color=[0 0.4470 0.7410];  % orig_ab Receiver1
fig2.Children(13).Children(4).Color=[0.8500 0.3250 0.0980]; % 5_pan Receiver1
fig2.Children(13).Children(3).Color=[0.9290 0.6940 0.1250]; % 5_ab Receiver1

hold on
legend('ModelR Recevier1','ModelR3 Recevier1','ModelT Recevier1','ModelT3 Recevier1')



%% Plot Revertime
figure;
x = [1 2 3 4];
y1 = [t1.reverbTime(3) t2.reverbTime(3) t3.reverbTime(3) t4.reverbTime(3) ];
y2 = [t1.reverbTime(4) t2.reverbTime(4) t3.reverbTime(4) t4.reverbTime(4) ];
y3 = [t1.reverbTime(5) t2.reverbTime(5) t3.reverbTime(5) t4.reverbTime(5) ];
y4 = [t1.reverbTime(6) t2.reverbTime(6) t3.reverbTime(6) t4.reverbTime(6) ];
y5 = [t1.reverbTime(7) t2.reverbTime(7) t3.reverbTime(7) t4.reverbTime(7) ];
y6 = [t1.reverbTime(9) t2.reverbTime(9) t3.reverbTime(9) t4.reverbTime(9) ];

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
xticklabels({'ModelR','','ModelR3','','ModelT','','ModelT3'})
title('RT60');

%% plot C80
figure;
x = [1 2 3 4];
y1 = [t1.C80(3) t2.C80(3) t3.C80(3) t4.C80(3) ];
y2 = [t1.C80(4) t2.C80(4) t3.C80(4) t4.C80(4) ];
y3 = [t1.C80(5) t2.C80(5) t3.C80(5) t4.C80(5) ];
y4 = [t1.C80(6) t2.C80(6) t3.C80(6) t4.C80(6) ];
y5 = [t1.C80(7) t2.C80(7) t3.C80(7) t4.C80(7) ];
y6 = [t1.C80(8) t2.C80(8) t3.C80(8) t4.C80(8) ];

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
xticklabels({'ModelR','','ModelR3','','ModelT','','ModelT3'})
title('C80');
%% plot D50
figure;
x = [1 2 3 4];
y1 = [t1.D50(3) t2.D50(3) t3.D50(3) t4.D50(3) ];
y2 = [t1.D50(4) t2.D50(4) t3.D50(4) t4.D50(4) ];
y3 = [t1.D50(5) t2.D50(5) t3.D50(5) t4.D50(5) ];
y4 = [t1.D50(6) t2.D50(6) t3.D50(6) t4.D50(6) ];
y5 = [t1.D50(7) t2.D50(7) t3.D50(7) t4.D50(7) ];
y6 = [t1.D50(8) t2.D50(8) t3.D50(8) t4.D50(8) ];

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
xticklabels({'ModelR','','ModelR3','','ModelT','','ModelT3'})
title('D50');
%% plot strength
figure;
x = [1 2 3 4];
y1 = [t1.G(3) t2.G(3) t3.G(3) t4.G(3) ];
y2 = [t1.G(4) t2.G(4) t3.G(4) t4.G(4) ];
y3 = [t1.G(5) t2.G(5) t3.G(5) t4.G(5) ];
y4 = [t1.G(6) t2.G(6) t3.G(6) t4.G(6) ];
y5 = [t1.G(7) t2.G(7) t3.G(7) t4.G(7) ];
y6 = [t1.G(8) t2.G(8) t3.G(8) t4.G(8) ];

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
xticklabels({'ModelR','','ModelR3','','ModelT','','ModelT3'})
title('Strength');
%% plot EDT
figure;
x = [1 2 3 4 ];
y1 = [t1.G(3) t2.G(3) t3.G(3) t4.G(3) ];
y2 = [t1.G(4) t2.G(4) t3.G(4) t4.G(4) ];
y3 = [t1.G(5) t2.G(5) t3.G(5) t4.G(5) ];
y4 = [t1.G(6) t2.G(6) t3.G(6) t4.G(6) ];
y5 = [t1.G(7) t2.G(7) t3.G(7) t4.G(7) ];
y6 = [t1.G(8) t2.G(8) t3.G(8) t4.G(8) ];


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
xticklabels({'ModelR','','ModelR3','', 'ModelT','', 'ModelT3'})
title('EDT');

%% average parameters

%ModelR
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


%% ModelR3
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


%% ModelT
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

%% ModelT3

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