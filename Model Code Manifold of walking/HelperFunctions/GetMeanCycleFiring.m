function Data = GetMeanCycleFiring(Data)
    DataF = Data.NormUFiring;
    MeanSpeedst = cellfun(@(x) GetResampSig(DataF(x,:),2000),Data.GoodCycles,'UniformOutput',false);
    MeanSpeedss = mean(cat(3,MeanSpeedst{:}),3);
    MeanSpeeds = MeanSpeedss./max(MeanSpeedss,[],1);
    %MeanSpeeds = MeanSpeedss; %
    Data.MeanCycleFiring = MeanSpeeds;
end