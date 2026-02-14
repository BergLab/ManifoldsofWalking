instances = 25;     % no. freezing trials
SegLength = 15000;  % length per trial
FreezeP = 3000;     % length of freezing period
t_steps = instances*SegLength;
Pop2 = logical(N.Types(:,2)); Pop3 = logical(N.Types(:,3)); Pop4 = logical(N.Types(:,4)); Pop1 = logical(N.Types(:,1)); Pop5 = logical(N.Types(:,5));

% Sample new gains for sp2 and sp4 for each trial
g2 = linspace(0.8,1.2,100)+0.1; g4 = linspace(1.2,0.8,100)+0.1; ix = randperm(instances,instances)';
ik = nonLinspace(1,100,instances,'exp10');
g2 = g2(round(ik)); g4 = g4(round(ik));
g2 = g2(ix); g4 = g4(ix);


GlobalIe = 40; % Global external input 
Segs = SegLength:SegLength:t_steps;
FreezeT = [];
StimT = [];
dur = 100;
subset = 400;

Gain = ones(Length,t_steps);                                                                  % Baseline gain (activation function slope) for each neuron

threshold = ones(size(Gain,1),1).*40 + repmat(normrnd(0,2,[size(N.ConnMat,1) 1]),[1 1]);
threshold = abs(threshold);                                                                   % Threshold noise across network

fmax = ones(size(Gain,1),1).*40 + repmat(normrnd(0,2,[size(N.ConnMat,1) 1]),[1 1]);
fmax = abs(fmax);                                                                             % Max firing noise across network

for ii = 1:length(Segs)
    Gain(Pop2,(Segs(ii)-(SegLength-1)):Segs(ii)) = g2(ix(ii));
    Gain(Pop4,(Segs(ii)-(SegLength-1)):Segs(ii)) = g4(ix(ii));
end

Gain = Gain + repmat(normrnd(0,0.05,[size(N.ConnMat,1) 1]),[1 t_steps]);                      % Gain noise across network
Gain = abs(Gain);
