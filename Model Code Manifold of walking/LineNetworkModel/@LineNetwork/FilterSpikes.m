function obj = FilterSpikes(obj,w,fs)
obj.FilteredSpikes = GaussianFilter(obj.Spikes,w,fs);
end