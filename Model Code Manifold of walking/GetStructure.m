Data.UFiring = N.FilteredSpikes;
Data.NormUFiring = GetNormalizeMatrixColumn(Data.UFiring);
Data.IsFreezing = FreezeT; 
%Data.Stim = StimT;
[~,Data.NPCs] = pca(Data.NormUFiring); 
Data.Gain = Gain;
Data.Threshold = threshold(:,1);
Data.Fmax = fmax(:,1);
Data.Ie = I_e;
N.FilteredSpikes = []; N.Spikes = []; Data.Network = N;
Cycles = {};
s = Data.NPCs(:,1);
s = movmean(s,20);
[~,IndS] = findpeaks(s,'MinPeakHeight',.2*std(s),'MinPeakDistance',200,'MinPeakProminence',.2*std(s));
for jj = 1:length(IndS(1:end-1))
    c = IndS(jj):IndS(jj+1);
    if range(c) > 1000
        continue
    end
    Cycles{length(Cycles)+1} = c;
end
Data.GoodCycles = Cycles;
bad = cellfun(@(x) any(ismember(x,Data.IsFreezing)),Data.GoodCycles);
Data.GoodCycles = Data.GoodCycles(~bad);
Data = GetMeanCycleFiring(Data);
[c,~,l] = pca(Data.MeanCycleFiring);
Data.NPCc = c;
Data.NPCs = Data.UFiring*c;
Data.NormUFiring = [];
