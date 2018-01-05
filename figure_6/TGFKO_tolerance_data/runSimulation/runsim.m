function [X] = runsim(pars)
%%% run simulation of microglia model
%%% model for continuous LPS application starting at t = tss
%%% two stimuli are imposed with varying amplitudes and isi

global h 

%%% model parameters and simulation parameters:
p       = params();         % model parameters
ti      = -24;              % initial time (hours) 
days    = 4;                % days of simulation time
tf      = days*24;          % total hours of simulation time
dt      = 0.1;              % time step for saving simulation data (hr)
tspan   = ti:dt:tf;         % time span for simulation traces
tss     = ti + 24;          % time for LPS stimulus to start
stim1    = pars(2);         % LPS concentration, stimulus 1
stim2    = pars(3);         % LPS concentration, stimulus 3
tdur    = 2;                % LPS stimulation duration
tss2    = tss + pars(1);    % time for second LPS stimulus to start

del = 0.1;

% LPS stimulus profile:
LPS = [tspan; zeros(1,length(tspan))]';
for t = 1:length(tspan)
    if tspan(t) < tss
        LPS(t,2) = 0;
    end

    if (tspan(t)>=tss && (tspan(t)<=(tss+tdur)))
        LPS(t,2) = stim1;
    end

    if ((tspan(t)>(tss+tdur)) && tspan(t)<tss2)
        LPS(t,2) = del;
    end

    if (tspan(t)>=tss2 && (tspan(t)<=(tss2+tdur)))
        LPS(t,2) = stim2;
    end

    if (tspan(t) > (tss2+tdur))
        LPS(t,2) = del;
    end
end

%%% call ode function and run the simulation:
h = 0;
myIC = 0.1*ones(6,1);   % initial conditions vector
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9,...
        'InitialStep',dt,'MaxStep',dt,'NonNegative',1); 
[t,X]   = ode45(@odefn, tspan, myIC, options, p, LPS);

















