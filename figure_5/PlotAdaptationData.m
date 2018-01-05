% plot adaptation data
% three genetic conditions: baseline, IL10-KO, TGF-KO
% without delays

clear all

% import data without delays:
Base_noDelay    = dlmread('baseline_noDelay.txt');
Il10KO_noDelay  = dlmread('Il10KO_noDelay.txt');
TgfKO_noDelay   = dlmread('TGFKO_noDelay.txt');

% plot characteristics
h = 2000;
w = 1000;
FigHandle = figure;
set(FigHandle, 'Position', [1, 1, w, h]);
linethick = 3;
sizefont = 12;
xticks = [0.1 1 10 100 1000];
xlims = [0.03 3000];

% adaptation example
% alpha function parameters and example
Pmax1   = 10;
adapt   = 3;
tau     = 3;
t       = 0:(tau/100):10*tau;
syn     = (Pmax1/tau).*(t.*exp(1-t./tau)) + adapt.*(1-exp(-t./tau));
wave    = zeros(round(1.1*length(t)),1);
wave((length(wave)-length(t)+1):length(wave)) = syn';
subplot(2,3,1); hold on
plot(wave,'k','Linewidth',3);
x = 0:1200;
y1 = zeros(1,length(x));
y2 = adapt.*ones(1,length(x));
y3 = 12.*ones(1,length(x));
plot(x,y1,'k--','Linewidth',2);
plot(x,y2,'k--','Linewidth',2);
plot(x,y3,'k--','Linewidth',2);
axis([0 1000 -1 13]);
set(gca,'Visible','off');

mark = 12;

%%% plot data
subplot(2,3,2);
semilogx(Base_noDelay(:,1),Base_noDelay(:,2),'k','Linewidth',linethick); hold on
semilogx(Il10KO_noDelay(:,1),Il10KO_noDelay(:,2),'k.','Markersize',mark);
semilogx(TgfKO_noDelay(:,1),TgfKO_noDelay(:,2),'k--','Linewidth',linethick);
set(gca,'Xticklabel',xticks,'Fontname','Ariel','Fontsize',sizefont);
set(gca,'Box','on');
ylabel('Adaptation (1 - b/a)');
xlabel('[LPS] (A.U.)');
legend('Baseline','IL10-KO','TGF-KO');

ylim([-0.1 1.1])

subplot(2,3,3);
semilogx(Base_noDelay(:,1),Base_noDelay(:,3),'k','Linewidth',linethick); hold on
semilogx(Il10KO_noDelay(:,1),Il10KO_noDelay(:,3),'k.','Markersize',mark);
semilogx(TgfKO_noDelay(:,1),TgfKO_noDelay(:,3),'k--','Linewidth',linethick);
set(gca,'Xticklabel',xticks,'Fontname','Ariel','Fontsize',sizefont);
set(gca,'Box','on');
ylabel('TNF peak (A.U.)');
xlabel('[LPS] (A.U.)');
ylim([-4 80])

subplot(2,3,4);
semilogx(Base_noDelay(:,1),Base_noDelay(:,4),'k','Linewidth',linethick); hold on
semilogx(Il10KO_noDelay(:,1),Il10KO_noDelay(:,4),'k.','Markersize',mark);
semilogx(TgfKO_noDelay(:,1),TgfKO_noDelay(:,4),'k--','Linewidth',linethick);
set(gca,'Xticklabel',xticks,'Fontname','Ariel','Fontsize',sizefont);
set(gca,'Box','on');
ylabel('TNF steady-state (A.U.)');
xlabel('[LPS] (A.U.)');
ylim([-2 40])

subplot(2,3,5);
semilogx(Base_noDelay(:,1),Base_noDelay(:,5),'k','Linewidth',linethick); hold on
semilogx(Il10KO_noDelay(:,1),Il10KO_noDelay(:,5),'k.','Markersize',mark);
semilogx(TgfKO_noDelay(:,1),TgfKO_noDelay(:,5),'k--','Linewidth',linethick);
set(gca,'Xticklabel',xticks,'Fontname','Ariel','Fontsize',sizefont);
set(gca,'Box','on');
ylabel('TNF ttp (hr)');
xlabel('[LPS] (A.U.)');
ylim([0 80])

subplot(2,3,6);
semilogx(Base_noDelay(:,1),Base_noDelay(:,6),'k','Linewidth',linethick); hold on
semilogx(Il10KO_noDelay(:,1),Il10KO_noDelay(:,6),'k.','Markersize',mark);
semilogx(TgfKO_noDelay(:,1),TgfKO_noDelay(:,6),'k--','Linewidth',linethick);
set(gca,'Xticklabel',xticks,'Fontname','Ariel','Fontsize',sizefont);
set(gca,'Box','on');
ylabel('TNF AUC (A.U.)');
xlabel('[LPS] (A.U.)');
ylim([-20 3500])


