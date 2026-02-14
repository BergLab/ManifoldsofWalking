clear;
% Instantiate network and baseline simulation parameters
run BaseNet.m
run BaseParameterSetup.m

% Freeze-inducing input for population candidate
I_e = ones(Length,t_steps)*GlobalIe + repmat(normrnd(0,2,[size(N.ConnMat,1) 1]),[1 t_steps]); % Input noise across network
POI = Pop2;
deltainput = 18;
for ii = 1:length(Segs)
    I_e(POI,(Segs(ii)-FreezeP):Segs(ii)) =I_e(POI,(Segs(ii)-FreezeP):Segs(ii)) - repmat(normrnd(deltainput,2,[nnz(POI) 1]),[1 FreezeP+1]);
    FreezeT = [FreezeT (Segs(ii)-FreezeP):Segs(ii)];
end

N.SimulateLine(t_steps,'gain',Gain,'I_e',I_e,'gain_noise',false,...
    'threshold',threshold,'fmax',fmax,'noise_ampl',0.5);                    % Simulate with paremeter setup
N.ComputeSpikes; N.Voltage = []; N.Rates = [];                              % Generate spikes from firing rates
N.FilterSpikes(25,1000);                                                    % Filter into continuous traces
run GetStructure.m                                                          % Build PCA space from "mean cycle" and package parameters and low-dimensional traces

% Plotting
figure;
subplot(1,3,1); 
run Plot.m
title("Silencing sp2/V1",'FontWeight','normal','FontSize',15);
Data_sp2 = Data; clearvars Data

% Freeze-inducing input for population candidate
I_e(:,:) = repmat(I_e(:,1), [1 t_steps]); % Reuse global input structure
POI = Pop3;
deltainput = 12;
for ii = 1:length(Segs)
    I_e(POI,(Segs(ii)-FreezeP):Segs(ii)) =I_e(POI,(Segs(ii)-FreezeP):Segs(ii)) - repmat(normrnd(deltainput,2,[nnz(POI) 1]),[1 FreezeP+1]);
    FreezeT = [FreezeT (Segs(ii)-FreezeP):Segs(ii)];
end

N.SimulateLine(t_steps,'gain',Gain,'I_e',I_e,'gain_noise',false,...
'threshold',threshold,'fmax',fmax,'noise_ampl',0.5);                        % Simulate with paremeter setup
N.ComputeSpikes; N.Voltage = [];                                            % Generate spikes from firing rates
N.FilterSpikes(25,1000);                                                    % Filter into continuous traces
run GetStructure.m                                                          % Build PCA space from "mean cycle" and package parameters and low-dimensional traces

% Plotting
subplot(1,3,2); 
run Plot.m
title("Silencing sp3/V2a",'FontSize',15,'FontWeight','normal');
Data_sp3 = Data; clearvars Data

% Freeze-inducing input for population candidate
I_e(:,:) = repmat(I_e(:,1), [1 t_steps]); % Reuse global input structure
POI = Pop4;
deltainput = 21;
for ii = 1:length(Segs)
    I_e(POI,(Segs(ii)-FreezeP):Segs(ii)) =I_e(POI,(Segs(ii)-FreezeP):Segs(ii)) + repmat(normrnd(deltainput,2,[nnz(POI) 1]),[1 FreezeP+1]);
    FreezeT = [FreezeT (Segs(ii)-FreezeP):Segs(ii)];
end

N.SimulateLine(t_steps,'gain',Gain,'I_e',I_e,'gain_noise',false,...
'threshold',threshold,'fmax',fmax,'noise_ampl',0.5);                        % Simulate with paremeter setup
N.ComputeSpikes; N.Voltage = [];                                            % Generate spikes from firing rates
N.FilterSpikes(25,1000);                                                    % Filter into continuous traces
run GetStructure.m                                                          % Build PCA space from "mean cycle" and package parameters and low-dimensional traces

% Plotting
subplot(1,3,3); 
run Plot.m
title("Activating sp4/V2b",'FontSize',15,'FontWeight','normal');
Data_sp4 = Data; 

clearvars -except Data_sp2 Data_sp3 Data_sp4