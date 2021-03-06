#!/bin/bash

noc=20
for i in {1..20}
do

cat > TolVar${i}.m<<EOF
clc
clear all

interval = [3,6,12,18,24,30,36,42,48,72];
LPS_1 = logspace(1,3,20);
LPS_2 = logspace(1,3,20);
numSim = length(interval)*length(LPS_1)*length(LPS_2);
pars = zeros(numSim,3);

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

fid = fopen('TolNoDelay${i}.bin','w');

for h = (200*(${i}-1)+1):(200*${i})
X = runsim(pars(h,:));
fwrite(fid,X,'double');
end

EOF
(matlab -nosplash -nodesktop < TolVar${i}.m > log${i} &)
done