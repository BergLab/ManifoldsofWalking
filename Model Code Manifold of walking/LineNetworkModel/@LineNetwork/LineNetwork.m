classdef LineNetwork < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Coordinates         % spatial coordinates of each neuron, length(coords) = network length, keeping neuron density fixed
        Rates               % time x n rate matrix
        Voltage             % time x n input potential matrix
        Spikes
        ConnMat             % n x n connectivity matrix
        E                   % n x 1 logical index of excitatory units
        I                   % n x 1 logical index of inhibitory units
        PDFs                % spatial projection pdfs for the five subpopulations 
        Size                % size (n) of network, equal to length to fix density
        Length              % spatial length of network
        Means           % 5 x 1 vector mean (Gaussian) projection lengths for each of the 5 subpopulations over the normalized pair-wise distance domain  
        Vars
        Types               % n x 5 logical indices for subpopulations
        NPCs
        NPCc
        FilteredSpikes
     
    end
    
    methods
        function obj = LineNetwork(Length,Means,Vars)

            obj.Means = Means;
            obj.Vars = Vars;
            obj.Length = Length;
            obj.Size = Length;
            obj = Instantiate2(obj); % Builds the network from basic parameters
            obj.Voltage = [];
            obj.Rates = []; 
            obj.Spikes = [];
            obj.FilteredSpikes = [];
        end

        
    end
    
    methods (Access = public)

        SimulateLine(obj,t_steps,varargin); % Simulates network, t_steps is duration of sim in milliseconds 
        GainMod(obj,Pop,Gain,normalizeFlag); % Scales synaptic weights of population of interest (Pop = 1 , ... , 5) by scaling factor Gain. 
        PlotRaster(obj,varargin);
        ComputeSpikes(obj,varargin);
        FilterSpikes(obj,w,fs);
    end

end

