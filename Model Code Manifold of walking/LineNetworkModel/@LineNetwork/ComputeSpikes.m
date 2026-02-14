function obj = ComputeSpikes(obj,varargin)
        UoI = true(size(obj.ConnMat,1),1);
        for ii = 1:2:length(varargin)
            switch varargin{ii}
                case 'UoI'
                   UoI = varargin{ii+1};
            end
        end
        RI =  obj.Rates(1:end,UoI);
        RIsp = ((RI-min(RI,[],1)));
        RIsp = RIsp./(max(RIsp,[],1));
        Poiss = poissrnd(RIsp/50,size(RIsp));
        obj.Spikes = logical(Poiss);
end