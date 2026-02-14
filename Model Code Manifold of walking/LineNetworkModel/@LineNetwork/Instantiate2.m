function obj = Instantiate2(obj)
    
    % Params
    
    gain = 1;
    Var = 0.1;
    n = obj.Length;
    obj.Coordinates = linspace(0,n,n);
    Dist = -bsxfun(@minus,obj.Coordinates,obj.Coordinates');
    L = round(range(obj.Coordinates),2);
    edges = [-L:10:L];
    DistDomain = 1:length(edges)-1;
    W = zeros(size(Dist));
    obj.PDFs = zeros(5,length(DistDomain));

    
    fs = [0.1 0.25 0.3 0.25 0.1]; % Pop fractions
    
    full_ix = [];
    for jj =1:n/20
        ix = [];
        for ii=1:5
            ix = [ix; ones(fs(ii)*20,1).*ii];
        end
        ix = ix(randperm(20,20)'); % Uniform position scrambling
        full_ix = [full_ix; ix];
    end


    for ii = 1:5 % Define connection probabilites from pair-wise distances and Gaussians and built connectivity matrix
        obj.Types(:,ii) = (full_ix==ii);
        dist =  Dist(:,logical(obj.Types(:,ii)));
        Y = discretize(dist,edges);
        ProjIx = DistDomain(int32(length(DistDomain)*obj.Means(ii)));
        PDF = exp(-(DistDomain - ProjIx).^2 / (2 * obj.Vars(ii)^2));
        PDF = [0 PDF(1:end-1)] + PDF;  % I do this step to improve the discrete sampling, by making the PDF symmetric around the specified mean projection distance
        PDF = PDF/sum(PDF);
        Prob = 30*PDF(int32(Y)); %8 for
        Prob(Prob > 1) = 1;
        Syns = binornd(1,Prob);
        Weights = abs(normrnd(gain,Var,size(Syns))).*Syns;
        W(:,logical(obj.Types(:,ii))) = Weights;
        obj.PDFs(ii,:) = PDF';
    end

    W(:,logical(obj.Types(:,2) + obj.Types(:,4))) = W(:,logical(obj.Types(:,2) + obj.Types(:,4))).*-1;
    [W,~] = BalanceNormalize(W);
    obj.ConnMat = W; % Final net

    % Indices of exc and inh neurons
    obj.I = logical(obj.Types(:,2) + obj.Types(:,4));
    obj.E = zeros(length(obj.I),1);
    obj.E(~obj.I) = true;
    obj.E = logical(obj.E);

    return
end