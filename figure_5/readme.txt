Files to plot the data for Fig 5D-I:

Note. There are three folders including "Baseline_adaptation_data", "IL10KO_adaptation_data", and "TGFKO_adaptation_data". These folders contain the code to generate and analyze the data for each respective phenotype (i.e., WT, IL-10 KO, and TGFb KO). See the readme.txt files in each folder for further details. The data produced are in the files "baseline_noDelay.txt", "IL10KO_noDelay.txt", and "TGFKO_noDelay.txt".

1. PlotAdaptationData.m		- this file runs takes computed data and generates plots
2. baseline_noDelay.txt 	- this file contains WT adaptation data (see folder "Baseline_adaptation_data")
3. IL10KO_noDelay.txt 		- this file contains IL-10 adaptation data (see folder "IL10KO_adaptation_data")
4. TGFKO_noDelay.txt 		- this file contains TGFb KO adaptation data (see folder "TGFKO_adaptation_data")
5. Fig5D-I.png              	- plots from Fig 5D-I
Note: Data in .bin files are unavailable on the ModelDB database, a complete package of code and data can be accessed here:
https://www.dropbox.com/sh/nqum7477dcyyesh/AABJJrQ695DF-WIoSz7LFSPla?dl=0

Instructions

The following command, entered into the MATLAB interface, will produce the plots in Fig 5D-I:
	
	>> PlotAdaptationData