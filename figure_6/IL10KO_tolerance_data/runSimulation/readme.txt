Files to run the model and generate the data in Fig 6 for the IL-10 KO model phenotype:

1. tolerance.sh	- shell script for running simulations in parallel
2. TolVar1.m 		- sample MATLAB file generated by tolerance.sh
3. runsim.m 		- this file runs the simulation, called by MATLAB files generated by tolerance.sh
4. params.m 		- this file contains all model parameters
5. odefn.m 		- this file contains the ODE model

Instructions

Run the followung command from a unix shell with MATLAB installed:

	sh tolerance.sh