rng('shuffle');
% NET PARAMS
Length = 500;
Vars = [11.4000 14.4000 16.4000 14.4000 11.4000].*0.5;
Means = [0.1600 0.3500 0.5000 0.6500 0.8400]+0.005;

% INSTANTIATE
N = LineNetwork(Length,Means,Vars);
N.ConnMat = N.ConnMat.*1.2;

