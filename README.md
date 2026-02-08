# Model Network Simulations

## Dependencies
The code was developed and tested in MATLABR2025B and requires MathWorks Toolboxes:
'Signal Processing Toolbox', 
'Statistics and Machine Learning Toolbox'

## DeNovoBase
The script file **DeNovoBase.m** instantiates a 1D network object, samples external and intrinsic dynamical parameters across the neurons, simulates and finally plots the network activity traces in the 3D principal component space.

First **BaseNet.m** is called, which instantiates the 500 unit 1D network from arguments **Vars** and **Means**. These vectors set the mean and variance of Gaussian projection distances for each of the 5 subpopulations.    

Subsequently, **BaseParameterSetup.m** sets up neuronal parameters for a 25 trial simulation of walk-to-stop transitions, each trial segment consisting of 12 s of "locomotion" followed by 3 s of "arrest". These include Gaussian sampling of dynamical parameters _gain_, _threshold_ and _fmax_ over the network.

Then the external input object *I_e* is constructed, sampling the change in drive to the population of interest (here, subpopulation 2) at each "arrest" onset. The network is then simulated with the instantiated parameters using the object method **SimulateLine()**. From simulated firing rates, Poisson spikes are generated using **ComputeSpikes()** which are filtered back into traces using a Gaussian kernel in **FilterSpikes()**. Finally,
**GetStructure.m** packages the results into a structure array where locomotor cycles are extracted, averaged and used to construct a 3D space spanned by its 3 leading principal components. The network activity traces are visualized in this projection space by calling **Plot.m**. Subsequent chunks, where arrest is induced through targeted input to subpopulation 3 and 4, follow identical logic.

## DeNovoPerturbation
The script file **DeNovoPerturbation.m** does the same as the base script, but investigates the dynamical stability 
of the stationary arrest state in each trial segment. In the middle of each arrest period, 400 randomly chosen units recieve a strong 100 ms long excitatory input, sampled from a Gaussian distribution with μ=80 and σ=5. 

## denovoPopulationSubset

The script file **denovoPopulationSubset.m** runs similar simulations for the 3 subppopulations of interest, however, only a random fraction of the subpopulation is strongly inhibited/excited (+/-200 input) in an attempt to induce arrest across the trials. Subpopulation fractions tested here are 1, 0.5, 0.25 and 0.1.
