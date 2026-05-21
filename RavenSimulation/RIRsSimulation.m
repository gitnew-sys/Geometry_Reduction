%% From the ita_raven_demo
% project laden
ccx
ravenProjectPath = 'eg_reference.rpf';

if (~exist(ravenProjectPath,'file'))
    [filename, pathname] = uigetfile('0.0001_with_material_onemodel_final3', 'Please select raven project file!');
    ravenProjectPath = [pathname filename];
end
% ravenBasePath = ravenProjectPath(1:end-34);

rpf = itaRavenProject(ravenProjectPath);
%% Simulationsparameter einstellen
% Image sources up to second order
rpf.setISOrder_PS(1);
N = rpf.getNumberOfParticlesRecommendation();
% 20000 ray tracing partikel
rpf.setNumParticles(85000);

% set impulse response length in ms (at least length of reverberation time)
rpf.setFilterLength(2800);  %[ms]
% rpf.setFilterLengthToReverbTime();    % estimates reverberation time and
% sets rpf.filterLength to this value

% set room temperature
rpf.setTemperature(21); %°C


%% Define simulation outputs
% activate image source simulation
rpf.setSimulationTypeIS(1);

% activate ray tracing simulation
rpf.setSimulationTypeRT(1);

% create mono room impulse response
rpf.setGenerateRIR(1);

% create binaural room impulse response
rpf.setGenerateBRIR(1);

% create and export energy histograms
rpf.setExportHistogram(1);  % histogramme z.B. benötigt für schnelle Nachhallzeitauswertung (RavenProject.getT30)


%% Quell- und Empfängerdaten
% for matlab write model
% %  
% rpf.setSourceViewVectors([0 -1 0]);
% rpf.setSourcePositions([-10.632933, 10.496125, -8.962928]);
% rpf.setReceiverPositions([-7.364849, -1.200000, -8.974772; -12.364889, -2.610000, -8.835598]);
% rpf.setReceiverViewVectors([0 1 0]);

% % for mannual model eurogress
rpf.setSourceViewVectors([1 0 0]);
rpf.setSourcePositions([-10, -7, 10]);
rpf.setSourceUpVectors([0 1 0]);
rpf.setSourceNames('Source');
rpf.setReceiverPositions([7, -7, 17; 7, -10, 4]);
rpf.setReceiverViewVectors([-1 0 0;-1 0 0]);
rpf.setReceiverUpVectors([0 1 0; 0 1 0]);

% for mannual model simpleroom
% rpf.setSourceViewVectors([1 0 0]);
% rpf.setSourcePositions([0.5, 1, 6]);
% rpf.setSourceUpVectors([0 1 0]);
% rpf.setSourceNames('Source');
% rpf.setReceiverPositions([3, 2.5, 13; 3.5, 3.5, 3]);
% rpf.setReceiverViewVectors([-1 0 0;-1 0 0]);
% rpf.setReceiverUpVectors([0 1 0; 0 1 0]);


% set source directivity 
rpf.setSourceDirectivity('KH_O100_Oli_5x5_3rd_relativiert_auf_azi0_ele0.daff');

%% start simulation 
% run simulation
rpf.run;

%% Ergebnisse abholen
% get room impulse responses
mono_ir = rpf.getImpulseResponseItaAudio();    % rpf.rpf.getImpulseResponse() without ITA-Toolbox
AutomaticModelRIRs = mono_ir;
% binaural = rpf.getBinauralImpulseResponseItaAudio();
reverb_time = rpf.getT30();

EDT = rpf.getEDT();
Definition = rpf.getDefinition();
% IACC = rpf.getIACC;
%LFC = rpf.getLFC();
G = rpf.getStrength();
%clarity
[C50, C80] = rpf.getClarity();
%definition
[D50, D80] = rpf.getDefinition();
%EDT
 
schroeder = rpf.getSchroederCurve_itaResult();

Freq = rpf.freqLabelOct';
receiver1.Clarity50 = C50{1}';
receiver1.Clarity80 = C80{1}';
receiver1.Definition50 = D50{1}';
receiver1.Definition80 = D80{1}';
receiver1.reverb_time = reverb_time{1};  
receiver1.EDT = EDT{1}; 
receiver1.G = G{1}'; 

T = table;
T.Frequenzband = Freq;
T.reverbTime = receiver1.reverb_time;
T.C50 = receiver1.Clarity50;
T.C80 = receiver1.Clarity80;
T.D50 = receiver1.Definition50;
T.D80 = receiver1.Definition80;
T.EDT = receiver1.EDT;
T.G = receiver1.G;
T

Freq = rpf.freqLabelOct';
receiver2.Clarity50 = C50{2}';
receiver2.Clarity80 = C80{2}';
receiver2.Definition50 = D50{2}';
receiver2.Definition80 = D80{2}';
receiver2.reverb_time = reverb_time{2};  
receiver2.EDT = EDT{2}; 
receiver2.G = G{2}'; 


T2 = table;
T2.Frequenzband = Freq;
T2.reverbTime = receiver2.reverb_time;
T2.C50 = receiver2.Clarity50;
T2.C80 = receiver2.Clarity80;
T2.D50 = receiver2.Definition50;
T2.D80 = receiver2.Definition80;
T2.EDT = receiver2.EDT;
T2.G = receiver2.G;
T2

save ModelA_reference2.mat mono_ir T T2

%% ITA-Toolbox......

mono_ir(1).plot_time;
%xlim([0 0.2]);

mono_ir(2).plot_time;
%xlim([0 0.2]);
% plot mono RIR in time domain
%binaural.plot_time_dB;     % plot binaural RIR in time domain

%% Example: Include loudspeaer frequency response in RIR (for comparisons with measurements)
% pathFrequencyResponse = '..\RavenDatabase\FrequencyResponse\KH_O100_reference_holesclosed_final_at1V1m_fft14.ita';
% if (~exist(pathFrequencyResponse,'file'))
%     pathFrequencyResponse = [ ravenBasePath pathFrequencyResponse(4:end) ];
% end
% 
% ls_O100 = ita_read(pathFrequencyResponse);
% ir_mit_lautsprecher = ita_convolve(mono_ir, ls_O100);

%% Additional features
% show room model including sound sources
 rpf.plotModel;
 
 % show absorption coefficients
 rpf.plotMaterialsAbsorption;
 rpf.plotMaterialsScattering;