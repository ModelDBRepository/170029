
clc 
clear all

LPSstim = logspace(-1,3,100);
fid = fopen('Microgliavariation001.bin', 'w' );

for i=( (10*(1 - 1) + 1): (10*1))
X = runsim(LPSstim(i));
fwrite(fid,X,'double');
end

