#!/bin/bash

noc=10
for i in {1..10}
do

cat > LPSVar${i}.m <<EOF

clc 
clear all

LPSstim = logspace(-1,3,100);
fid = fopen('Microgliavariation00${i}.bin', 'w' );

for i=( (10*(${i} - 1) + 1): (10*${i}))
X = runsim(LPSstim(i));
fwrite(fid,X,'double');
end

EOF
(matlab -nosplash -nodesktop < LPSVar${i}.m> log${i} &)

done
