Files to run the model and generate the data in Fig 4, Fig S3, and Fig S4:

1. runICsims.m 		- run the model for variations in the initial conditions
2. params.m 		- this file contains all model parameters
3. odefn.m          	- this file contains the ODE model
4. DLEsims.bin  	- the results computed from running runICsims.m
5. ICsimAnalysis.m 	- file for analyzing data and generating figures
6. makeColormap.m 	- file used for heatmap color coordination
7. Fig4A.png        	- plots from Fig 4A, see Fig4A for plot annotations
Note: Data in .bin files are unavailable on the ModelDB database, a complete package of code and data can be accessed here:
https://www.dropbox.com/sh/nqum7477dcyyesh/AABJJrQ695DF-WIoSz7LFSPla?dl=0

Instructions

Enter the following command to generate all data for figures 4, S3, and S4:

	>> runICsims

This code will generate the data file DLEsims.bin. To analyze the data, enter

	>> ICsimAnalysis		