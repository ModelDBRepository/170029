Files to analyze the tolerance data generate the plot for the TGF KO model phenotype in Fig 6E:

1. Tolerance_Analysis.m	- Data analysis code to compute and plot Gain
2. makeColorMap.m       - code for coloring heatmaps
3. TolNoDelayx.bin      - data files, x = 1 to 20
4. Fig6E_TGFKO.png      - plot from Fig 6E, TGFb KO phenotype

Instructions

First generate the data (see folder "runSimulation"). The data will be in a series of files named "TolNoDelayx.bin" where x is an integer between 1 and 20.

To analyze the resulting data, open MATLAB and enter:

	>> Tolerance_Analysis

