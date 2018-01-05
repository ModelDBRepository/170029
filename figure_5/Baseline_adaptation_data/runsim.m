function X = runsim(LPSstim)
%%% run simulation of microglia model
%%% model for continuous LPS application starting at t = 0
global h

%%% model parameters and simulation parameters:
p       = params();         % model parameters
ti      = -24;              % initial time (hours) 
days    = 3;                % days of simulation time
tf      = days*24;          % total hours of simulation time
dt      = 0.1;              % time step for saving simulation data (hr)
tspan   = ti:dt:tf;         % time span for simulation traces

%%% call ode function and run the simulation:
h = 0;
myIC = 0.1*ones(6,1);   % initial conditions vector
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9,...
        'InitialStep',dt,'MaxStep',dt,...
        'NonNegative',1:6); 
[t,X]   = ode45(@odefn, tspan, myIC, options, p, LPSstim);

















