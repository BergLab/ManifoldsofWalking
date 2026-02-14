function FilteredAct = GaussianFilter(Activity,w,fs)
    

    theta = (w*fs)/1000;
    t = -4*theta:theta*4;
    kt = (1000/(sqrt(2*pi)*w))*exp(-(t.^2/(2*theta^2)));
    
    FilteredAct = zeros(size(Activity));
    for ii = 1:size(Activity,2)
        GFiring = conv(kt,Activity(:,ii));
        GFiring = GFiring(floor(length(t)/2):length(GFiring)-ceil(length(t)/2));
        FilteredAct(:,ii) = GFiring;
    end

end

