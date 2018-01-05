%%% run simulation of microglia model
%%% model for continuous LPS application (LPS = 1000) starting at t = 0
%%% this code generates the basic simulations shown in Fig1 and Fig S1A

clear all
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
h       = 0;                % index for time steps
IC      = 0.1*ones(6,1);    % initial conditions vector
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9,...
        'InitialStep',dt,'MaxStep',dt,...
        'NonNegative',1:6); 
[T,C] = ode45(@odefn, tspan, IC, options, p, stim); % T = time, C = cytokine data

%% plot simulation results

%%%% normalized results, Fig 1B
normC   = (C - repmat(min(C),length(T),1))./(repmat(max(C),length(T),1) - repmat(min(C),length(T),1));
figure; plot(T./24,normC,'Linewidth',3);
xlabel('Time (days)');
ylabel('Normalized Expression');
legend('IL-1b','TNFa','IL-6','TGF','IL-10','CCL5');

%%%% un-normalized results, Fig S1A
figure; plot(T./24,C,'Linewidth',3);
xlabel('Time (days)');
ylabel('Expression (A.U.)');
legend('IL-1b','TNFa','IL-6','TGF','IL-10','CCL5');











