%% mexall
mex combiner.c;
mex hyddelayv3.c;
mex asm1.c;
mex settler1dv4.c;
mex carboncombiner.c;


%% benchmarkinit
asm1init;
settler1dinit;
reginit;

load sensornoise.ascii
SENSORNOISE = sensornoise;
sensorinit;

dryinflu = readmatrix("dryinflu.xlsx");

starttime=14;
stoptime=28;

% noiseseed_SNO2 = 101-110(train) / 111-120(test)  