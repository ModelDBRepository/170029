% this file runs the model for a range of initial condition permutations
% and computes the data for figure 4
function [] = runICsims()
clc 
clear all

clc 
clear all

% vary the initial conditions for all 6 species
numIC   = 20;
ICrange = logspace(-2,1.3,numIC);

% loop simulating IC combinations:
fid = fopen('DLEsims.bin', 'w' );
for a = 1:numIC
    for b = 1:numIC
        for c = 1:numIC
            IC = 0.1.*ones(6,1);
            IC(2) = ICrange(a); % tnf
            IC(4) = ICrange(b); % tgf
            IC(5) = ICrange(c); % il10
            X = runsim(IC);
            fwrite(fid,X,'double');
        end
    end
end

end

function X = runsim(IC)
global h 

%%% model parameters and simulation parameters:
p       = params();         % model parameters
ti      = -24;              % initial time (hours) 
days    = 3;                % days of simulation time
tf      = days*24;          % total hours of simulation time
dt      = 0.1;              % time step for saving simulation data (hr)
tspan   = ti:dt:tf;         % time span for simulation traces
stim    = 1000;             % LPS concentration

%%% call ode function and run the simulation:
h = 0;
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9,...
        'InitialStep',dt,'MaxStep',dt,...
        'NonNegative',1:6); 
[t,X]   = ode45(@odefn, tspan, IC, options, p, stim);

end