clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ti      = -24;              % initial time (hours) 
days    = 3;                % days of simulation time
tf      = days*24;          % total hours of simulation time
dt      = 0.1;              % time step for saving simulation data (hr)
tspan   = ti:dt:tf;         % time span for simulation traces
stim    = 1000;             % LPS concentration
Tpts    = length(tspan);    % total number of time points
Nspec   = 6;                % number of species simulated

% vary the initial conditions for all 6 species
numIC   = 20;
ICrange = logspace(-2,1.3,numIC);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read in data and process data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tnf     = zeros(numIC,numIC,numIC,Tpts);    % TNFa traces
tgf     = zeros(numIC,numIC,numIC,Tpts);    % TGFb traces
il10    = zeros(numIC,numIC,numIC,Tpts);    % IL-10 traces
fid     = fopen('DLEsims.bin','r');
for a = 1:numIC
    for b = 1:numIC
        for c = 1:numIC
           data = reshape(fread(fid,(Tpts*Nspec),'double'),Tpts,Nspec);
           tnf(a,b,c,:)     = data(:,2);
           tgf(a,b,c,:)     = data(:,4);
           il10(a,b,c,:)    = data(:,5);
        end
    end
end
fclose(fid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute gradients and direct Lyapunov exponents (DLEs) for a set of time points 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_dle   = linspace(2,48,24);                        % times to evaluate DLEs (2-48 hrs)
DLE     = zeros(numIC,numIC,numIC,length(t_dle));   % DLE values
TNFx    = zeros(numIC,numIC,numIC,length(t_dle));   % grad of TNF in the direction of the TNF IC
TNFy    = zeros(numIC,numIC,numIC,length(t_dle));   % grad of TNF in the direction of the TGF IC
TNFz    = zeros(numIC,numIC,numIC,length(t_dle));   % grad of TNF in the direction of the IL10 IC
TGFx    = zeros(numIC,numIC,numIC,length(t_dle));   % grad of TGF in the direction of the TNF IC
TGFy    = zeros(numIC,numIC,numIC,length(t_dle));   % grad of TGF in the direction of the TGF IC
TGFz    = zeros(numIC,numIC,numIC,length(t_dle));   % grad of TGF in the direction of the IL10 IC
IL10x   = zeros(numIC,numIC,numIC,length(t_dle));   % grad of IL10 in the direction of the TNF IC
IL10y   = zeros(numIC,numIC,numIC,length(t_dle));   % grad of IL10 in the direction of the TGF IC
IL10z   = zeros(numIC,numIC,numIC,length(t_dle));   % grad of IL10 in the direction of the IL10 IC
for i = 1:length(t_dle)                                                                                     % i: DLE time point                                                 
    Tdle = find(tspan==t_dle(i));                                                                           % find the index of the appropriate time
    [TNFy(:,:,:,i),TNFx(:,:,:,i),TNFz(:,:,:,i)]    = gradient(tnf(:,:,:,Tdle),ICrange,ICrange,ICrange);     % x-component: change in the direction of the TNF IC
    [TGFy(:,:,:,i),TGFx(:,:,:,i),TGFz(:,:,:,i)]    = gradient(tgf(:,:,:,Tdle),ICrange,ICrange,ICrange);     % y-component: change in the direction of the TGF IC
    [IL10y(:,:,:,i),IL10x(:,:,:,i),IL10z(:,:,:,i)] = gradient(il10(:,:,:,Tdle),ICrange,ICrange,ICrange);    % z-component: change in the direction of the IL10 IC
    for a = 1:numIC                                                                                         % a: TNF IC index
        for b = 1:numIC                                                                                     % b: TGF IC index
            for c = 1:numIC                                                                                 % c: IL10 IC index
                TNFx(a,b,c,i)   = TNFx(a,b,c,i)*tnf(a,b,c,1)/tnf(a,b,c,Tdle);
                TNFy(a,b,c,i)   = TNFy(a,b,c,i)*tgf(a,b,c,1)/tnf(a,b,c,Tdle);
                TNFz(a,b,c,i)   = TNFz(a,b,c,i)*il10(a,b,c,1)/tnf(a,b,c,Tdle);
                TGFx(a,b,c,i)   = TGFx(a,b,c,i)*tnf(a,b,c,1)/tgf(a,b,c,Tdle);
                TGFy(a,b,c,i)   = TGFy(a,b,c,i)*tgf(a,b,c,1)/tgf(a,b,c,Tdle);
                TGFz(a,b,c,i)   = TGFz(a,b,c,i)*il10(a,b,c,1)/tgf(a,b,c,Tdle);
                IL10x(a,b,c,i)  = IL10x(a,b,c,i)*tnf(a,b,c,1)/il10(a,b,c,Tdle);
                IL10y(a,b,c,i)  = IL10y(a,b,c,i)*tgf(a,b,c,1)/il10(a,b,c,Tdle);
                IL10z(a,b,c,i)  = IL10z(a,b,c,i)*il10(a,b,c,1)/il10(a,b,c,Tdle);
                dX_dXo          = [TNFx(a,b,c,i) TNFy(a,b,c,i) TNFz(a,b,c,i); 
                                TGFx(a,b,c,i) TGFy(a,b,c,i) TGFz(a,b,c,i); 
                                IL10x(a,b,c,i) IL10y(a,b,c,i) IL10z(a,b,c,i)];
                S               = dX_dXo'*dX_dXo;
                DLE(a,b,c,i)    = log(max(eig(S)));
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the gradient of TNF in the direction of the IL-10 IC (Fig 4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TGF ic versus IL-10 ic for a data selection
% y axis: log TGFb initial condition
% x axis: log IL-10 initial condition
tnfaIC = [1 5 10 15 20];    % TNFa initial conditions to plot
tp_dle = [12 16 24 48];     % times to plot (hr)

f = figure;
set(f,'name','Fig 4 data','numbertitle','off')
cnt = 1;
for j = 1:length(tnfaIC)   
    jj = tnfaIC(length(tnfaIC) + 1 - j);         
    for i = 1:length(tp_dle)
        ii = find(t_dle==tp_dle(i));        
        data = reshape(TNFz(jj,:,:,ii),20,20);
        subplot(length(tnfaIC),length(tp_dle),cnt);        
        imagesc(log10(ICrange),log10(ICrange),data);        
        set(gca,'YDir','normal','Xticklabel',[],'Yticklabel',[]);
        caxis([-1 1]);        
        cnt = cnt + 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot the gradient of TNF in the direction of the TGFb IC (Fig S3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = figure;
set(f,'name','Fig S3 data','numbertitle','off')
cnt = 1;
for j = 1:length(tnfaIC)   
    jj = tnfaIC(length(tnfaIC) + 1 - j);         
    for i = 1:length(tp_dle)
        ii = find(t_dle==tp_dle(i));        
        data = reshape(TNFy(jj,:,:,ii),20,20);
        subplot(length(tnfaIC),length(tp_dle),cnt);        
        imagesc(log10(ICrange),log10(ICrange),data);        
        set(gca,'YDir','normal','Xticklabel',[],'Yticklabel',[]);
        caxis([-1 1]);        
        cnt = cnt + 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot of DLE data (Fig S4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f = figure;
set(f,'name','Fig S4 data','numbertitle','off')
cnt = 1;
for j = 1:length(tnfaIC)
    jj = tnfaIC(length(tnfaIC) + 1 - j);     
    for i = 1:length(tp_dle)        
        ii = find(t_dle==tp_dle(i));
        data = reshape(DLE(jj,:,:,ii),20,20)  ;
        subplot(length(tnfaIC),length(tp_dle),cnt);        
        a       = makeColorMap([1 1 1],[0.5 0.5 0.5],[0 0 0]); 
        colormap(a); 
        imagesc(log10(ICrange),log10(ICrange),data);         
        set(gca,'YDir','normal','Xticklabel',[],'Yticklabel',[]);
        caxis([0 3]);         
        cnt = cnt + 1;
    end
end


        




