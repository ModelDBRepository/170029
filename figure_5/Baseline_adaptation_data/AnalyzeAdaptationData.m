% Analyze adaptation data
% generated using adaptation.sh
% LPS stimulation concentration was varied
% based on running model with ode45

clear all

%% simulation parameters

% time parameters
ti      = -24;              % initial time (hours) 
days    = 3;                % days of simulation time
tf      = days*24;          % total hours of simulation time
dt      = 0.1;              % time step for saving simulation data (hr)
tspan   = ti:dt:tf;         % time span for simulation traces

% shell simulation parameters
Nsim    = 100;              % number of simulations
Nspec   = 6;                % number of species
Ncors   = 10;               % number of cores
Tpts    = length(tspan);    % number of time points

% LPS stimulation:
LPSstim = logspace(-1,3,Nsim);

%% read in data and process
Xall = zeros(Tpts,Nspec,Nsim);
k=1;
for i=1:Ncors
    
    fid =fopen(['Microgliavariation00',num2str(i),'.bin'],'r');
    
    for j=1:(Nsim/Ncors)
        Xall(:,:,k) = reshape(fread(fid,(Tpts*Nspec),'double'),Tpts,Nspec);
        k=k+1;
    end
    
    fclose(fid);
end

% re-format data
%	Column	Species
%	1	IL-1b, cols 1 to Nsim
%	2	TNFa, cols Nsim+1 to 2*Nsim
%	3	IL-6, cols 2*Nsim+1 to 3*Nsim
%	4	TGFb
%	5	IL-10
%	6	CCL5
X = zeros(Tpts,Nspec*Nsim);
for i = 1:Nspec
    X(:,(Nsim*(i-1)+1):i*Nsim) = reshape(Xall(:,i,:),Tpts,Nsim);
end

%% adaptation computations & plots

% compute mmeasurements for all cytokines:
maxs   = max(X); % max value for every column of X, 1-100: IL-b, 101:200: TNF, etc
sstate = X(length(tspan),:); % "steady-state" value at 3 days
auc    = sum(X).*dt - repmat(0.1*find(tspan==0)*dt,1,Nsim*6); % area under curve

% compute measurements for TNFa:
TimeToPeak = zeros(Nsim,1);
for j = Nsim+1:2*Nsim
    TimeToPeak(j-Nsim) = tspan((X(:,j) == max(X(:,j))));
end
Adaptation = 1- (sstate(Nsim+1:2*Nsim)-0.1)./(maxs(Nsim+1:2*Nsim)-0.1); 

% output data for aggregate plotting:
dat_out = zeros(length(LPSstim),6);
dat_out(:,1) = LPSstim;                 % col 1: LPS conc
dat_out(:,2) = Adaptation;              % col 2: adaptation of TNZF
dat_out(:,3) = maxs(Nsim+1:2*Nsim);     % col 3: peak TNF
dat_out(:,4) = sstate(Nsim+1:2*Nsim);   % col 4: peak TNF
dat_out(:,5) = TimeToPeak;              % col 5: time-to-peak TNF
dat_out(:,6) = auc(Nsim+1:2*Nsim);      % col 6: TNF AUC

dlmwrite('baseline_noDelay.txt',dat_out,'delimiter','\t');

