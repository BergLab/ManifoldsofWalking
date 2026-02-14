function obj = SimulateLine(obj,t_steps,varargin)

    W = obj.ConnMat;
    f_V_func = @tanh_f_V;  %@sigm_f_V;%
    tau_V = ones(size(W,1),1)*8;% 
    noise_ampl = 0.4;
    seed = 5;
    I_e = ones(size(W,1),t_steps).*40;
    V_init = 0;
    threshold = ones(size(W,1),1).*40;
    gain = ones(size(W,1),t_steps);
    f_max = ones(size(W,1),1).*40;
    gain_noise = false;
        

    for ii = 1:2:length(varargin)
        switch varargin{ii}
            case 'noise_ampl'
                noise_ampl = varargin{ii+1};
            case 'seed'
                seed = varargin{ii+1};
            case 'I_e'
                I_e = varargin{ii+1};
            case 'V_init'
                V_init = varargin{ii+1};
            case 'threshold'
                threshold = varargin{ii+1};
            case 'gain'
                gain = varargin{ii+1};
            case 'gain_noise'
                gain_noise = varargin{ii+1};
            case 'fmax'
                f_max = varargin{ii+1};
        end
    end

    rng(seed);
    N = size(W,1);
    V = zeros(N, t_steps);
    R = zeros(t_steps, N);  
%    R(1, :) = zeros(size(V_init));
  % V(:, 1) = normrnd(V_init,3,size(V(:, 1)));
    V(:, 1) = V_init;
    R(1, :) = tanh_f_V(V(:,1),threshold(:,1),gain(:,1),f_max);
    I_noise = normrnd(0.,noise_ampl,[1 (t_steps)*N]);
    I_rec = zeros(N, t_steps);
    I_tot = zeros(N, t_steps);
    I_noise = reshape(I_noise,size(I_tot));

    if gain_noise % Ornstein-Uhlenbeck
       g_traj = zeros(size(gain));
       mu = gain;
       g_traj(:,1) = mu(:,1);
       theta = 0.02; %0.01
       sigma = 0.01;
       for t = 2:t_steps
           dW = randn(size(W,1),1);
           mu_t = mu(:,t);
           g_traj(:,t) = g_traj(:,t-1) + theta.*(mu_t - g_traj(:,t-1)) + sigma.*dW;
       end
       gain = g_traj;
    end


    tic
    for t = 2:t_steps
        I_rec(:,t-1) = W*R(t-1,:)';
        I_tot(:,t-1) = I_rec(:,t-1) + I_noise(:,t-1) + I_e(:,t-1);
        dV = (-V(:,t-1) + I_tot(:,t-1))./tau_V(:);
        V(:,t) = V(:,t-1) + dV;
        R(t, :) = f_V_func(V(:,t), threshold(:), gain(:, t), f_max(:));
    end
    toc

    obj.Rates = R;
    obj.Voltage = V';

end

%% Helper Functions 
function val = tanh_f_V(V,threshold,gain,fmax) %20,1,100
    f = zeros(1,size(V,1)); 
    neg = (V-threshold)<=0.;
    pos = (V-threshold)>0;
    f(neg) = threshold(neg).*tanh(gain(neg).*(V(neg)-threshold(neg))./threshold(neg));
    f(pos) = fmax(pos).*tanh(gain(pos).*(V(pos)-threshold(pos))./fmax(pos));        
    val = f+threshold';
end


