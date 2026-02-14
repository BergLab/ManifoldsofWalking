clear;
% Instantiate network and baseline simulation parameters
run BaseNet.m
run BaseParameterSetup.m
I_e = ones(Length,t_steps)*GlobalIe + repmat(normrnd(0,2,[size(N.ConnMat,1) 1]),[1 t_steps]); % Input noise across network
f = [1,0.5,0.25,0.1];
figure;
for kk = 1:length(f)
    I_e(:,:) = repmat(I_e(:,1), [1 t_steps]); % Reuse global input structure
    POI = Pop2;
    Popf = find(POI);
    Popf = randsample(Popf,round(length(Popf)*f(kk)));
    deltainput = 200;
    for ii = 1:length(Segs)
        I_e(Popf,(Segs(ii)-FreezeP):Segs(ii)) =I_e(Popf,(Segs(ii)-FreezeP):Segs(ii)) - repmat(normrnd(deltainput,2,[nnz(Popf) 1]),[1 FreezeP+1]);
        FreezeT = [FreezeT (Segs(ii)-FreezeP):Segs(ii)];
    end
    
    N.SimulateLine(t_steps,'gain',Gain,'I_e',I_e,'gain_noise',false,...
        'threshold',threshold,'fmax',fmax,'noise_ampl',0.5);                    % Simulate with paremeter setup
    N.ComputeSpikes; N.Voltage = []; N.Rates = [];                              % Generate spikes from firing rates
    N.FilterSpikes(25,1000);                                                    % Filter into continuous traces
    run GetStructure.m
    subplot(1,4,kk);
    run Plot.m
    title(num2str(f(kk)))
end

figure;
for kk = 1:length(f)
    I_e(:,:) = repmat(I_e(:,1), [1 t_steps]); % Reuse global input structure
    POI = Pop3;
    Popf = find(POI);
    Popf = randsample(Popf,round(length(Popf)*f(kk)));
    deltainput = 200;
    for ii = 1:length(Segs)
        I_e(Popf,(Segs(ii)-FreezeP):Segs(ii)) =I_e(Popf,(Segs(ii)-FreezeP):Segs(ii)) - repmat(normrnd(deltainput,2,[nnz(Popf) 1]),[1 FreezeP+1]);
        FreezeT = [FreezeT (Segs(ii)-FreezeP):Segs(ii)];
    end
    
    N.SimulateLine(t_steps,'gain',Gain,'I_e',I_e,'gain_noise',false,...
        'threshold',threshold,'fmax',fmax,'noise_ampl',0.5);                    % Simulate with paremeter setup
    N.ComputeSpikes; N.Voltage = []; N.Rates = [];                              % Generate spikes from firing rates
    N.FilterSpikes(25,1000);                                                    % Filter into continuous traces
    run GetStructure.m
    subplot(1,4,kk);
    run Plot.m
    title(num2str(f(kk)))
end

figure;
for kk = 1:length(f)
    I_e(:,:) = repmat(I_e(:,1), [1 t_steps]); % Reuse global input structure
    POI = Pop4;
    Popf = find(POI);
    Popf = randsample(Popf,round(length(Popf)*f(kk)));
    deltainput = 200;
    for ii = 1:length(Segs)
        I_e(Popf,(Segs(ii)-FreezeP):Segs(ii)) =I_e(Popf,(Segs(ii)-FreezeP):Segs(ii)) + repmat(normrnd(deltainput,2,[nnz(Popf) 1]),[1 FreezeP+1]);
        FreezeT = [FreezeT (Segs(ii)-FreezeP):Segs(ii)];
    end
    
    N.SimulateLine(t_steps,'gain',Gain,'I_e',I_e,'gain_noise',false,...
        'threshold',threshold,'fmax',fmax,'noise_ampl',0.5);                    % Simulate with paremeter setup
    N.ComputeSpikes; N.Voltage = []; N.Rates = [];                              % Generate spikes from firing rates
    N.FilterSpikes(25,1000);                                                    % Filter into continuous traces
    run GetStructure.m
    subplot(1,4,kk);
    run Plot.m
    title(num2str(f(kk)))
end