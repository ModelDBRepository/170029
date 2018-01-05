% analyze the data
% vary the isi and pulse height for two pulses
% all three will be varied and will be simulated
% data generated using matlab parallel code 
% 20 cores, 4400 simulations


clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% generate variations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

interval    = [3,6,12,18,24,30,36,42,48,72];                % inter-stimulus intervals, ISI
LPS_1       = logspace(1,3,20);                             % first LPS pulse amplitude
LPS_2       = logspace(1,3,20);                             % second LPS pulse amplitude
numSim      = length(interval)*length(LPS_1)*length(LPS_2); % total number of simulations
pars        = zeros(numSim,3);                              % storage for pairings of ISI, LPS1, LPS2

% obtain all simulation input papameters (pairings of ISI, LPS1, LPS2)
x = 1;
for i = 1:length(interval)
    i_var = interval(i);
    for j = 1:length(LPS_1)
        j_var = LPS_1(j);
        for k = 1:length(LPS_2)
            k_var = LPS_2(k);
            pars(x,:) = [i_var,j_var,k_var];
            x = x + 1;
        end
    end
end

% time parameters:
ti      = -24;              % initial time (hours) 
days    = 4;                % days of simulation time
tf      = days*24;          % total hours of simulation time
dt      = 0.1;              % time step for saving simulation data (hr)
tspan   = ti:dt:tf;         % time span for simulation traces


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% load and save simulation results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ncors   = 20;               % number of cores
simcor  = 200;              % number of simulations per core
Tpts    = length(tspan);    % total number of time points
Nspec   = 6;                % number of species simulated
Nsim    = Ncors*simcor;     % total number of simulations

% read in data and process
Xall = zeros(Tpts,Nspec,Nsim);
k = 1;
for i = 1:Ncors
    
    fid =fopen(['TolNoDelay',num2str(i),'.bin'],'r');
    
    for j=1:simcor
        Xall(:,:,k) = reshape(fread(fid,(Tpts*Nspec),'double'),Tpts,Nspec);
        k=k+1;
    end
    
    fclose(fid);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot a subset of the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

int         = {'3','6','12','24','36','48','72'};
inter         = [3,6,12,24,36,48,72];
simperint   = length(LPS_1)*length(LPS_2);          % number of simulations per inter-stimulus interval
wt_data = zeros(simperint,3,length(inter));

indplt = 1;                                         % index for plotting a subset of the data                
x = 1;                                              % x, index for all simulations
isi = 0;                                            % isi, index for ISI  
saveWT = zeros(20,20,length(inter));
FigHandle = figure('Position', [500, 500, 900, 100]);
for i = 0:length(interval)-1                        % loop through each interval
    k = 1;                                          % k, index for inter-stimulus interval
    plots3d = zeros(simperint,3);                   % all TNFa data for a given ISI
    for j = 1:simperint                             % loop through all simulations of each interval
        plots3d(j,2:3) = pars(x,2:3);               % record the two LPS input levels
        data = reshape(Xall(:,2,i*400+j),Tpts,1);   % TNFa at all time for a given simulation
        
        indPk1  = find(tspan==0):find(tspan>=(2+interval(i+1)),1);
        pk1     = max(data(indPk1));
        indPk2  = find(tspan>=(2+interval(i+1)),1):length(tspan);
        pk2     = max(data(indPk2));
        
        plots3d(j,4) = pk1;
        plots3d(j,1) = pk2 / pk1;         % ratio of TNFa peaks
        
        k = k + 1;
        x = x + 1; 
    end    
    
    %%% plot the data, LPS2 (y) against LPS1 (x)
    isi     = isi + 1;
    zz      = log10( plots3d(:,1) ./ (plots3d(:,3) ./ plots3d(:,2)) ); % gain computation
    
    if (interval(i+1)==inter(indplt))
        subplot(1,7,indplt);        
        ZZ      = flipud(reshape(zz,20,20));
        saveWT(:,:,indplt) = ZZ;
        a       = makeColorMap([0 1 0],[1 1 1],[1 0 0]); 
        colormap(a); 
        h = pcolor(flipud(ZZ)); set(h,'EdgeColor','none');
        set(gca,'XTick',[],'YTick',[]);
        caxis([-2 2]) 
        axis equal tight
        
        wt_data(:,:,indplt) = [zz, plots3d(:,2:3)];
        indplt = indplt + 1;
        
        x1 = 0:1000; y1 = x1;
        hold on; plot(x1,y1,'--','color',[0.5 0.5 0.5],'Linewidth',2);
    end
    
    
end

