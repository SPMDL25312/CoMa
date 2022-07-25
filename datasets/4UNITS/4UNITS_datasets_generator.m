clear; clc
close all
% Arbitrary four-unit process datasets generator
% Written by SPMDL 07/25/2022


%% SET
err_case = 1;
% case1 : V1 (frequency fault (period of the signal decreases))
% case2 : V2 (phase change fault (signal shape changes))
% case3 : V3 (square wave fault (for the square wave fault, the switch is disabled, and only one signal type is sent))
% case4 : V6 (noise increment fault)
% case5 : V7 (exponentially decreasing amplitude fault)
% case6 : V12 (ramp linear increase fault)

seednum = 1;
% white-noise seed(1-10)

ws = 0; % xls write switch(1 = file save)
tgs = 1; % total_graph switch_(1 = plot on)
egs = 0; % each_graph switch(1 = plot on)

%%

A = 0:0.1:999.9; % train data
B = 0:0.1:1799.9; % test data

tdel1 = 200; % Unit(1)-(2,3) delay 
tdel2 = 300; % Unit(2,3)-(4) delay

Y1 = zeros(1,length(A));
Y2 = zeros(1,length(A));
Y3 = zeros(1,length(A));
Y4 = zeros(1,length(A));
Y5 = zeros(1,length(A));
Y6 = zeros(1,length(A));
Y7 = zeros(1,length(A));
Y8 = zeros(1,length(A));
Y9 = zeros(1,length(A));
Y10 = zeros(1,length(A));
Y11 = zeros(1,length(A));
Y12 = zeros(1,length(A));

Z1 = zeros(1,length(B));
Z2 = zeros(1,length(B));
Z3 = zeros(1,length(B));
Z4 = zeros(1,length(B));
Z5 = zeros(1,length(B));
Z6 = zeros(1,length(B));
Z7 = zeros(1,length(B));
Z8 = zeros(1,length(B));
Z9 = zeros(1,length(B));
Z10 = zeros(1,length(B));
Z11 = zeros(1,length(B));
Z12 = zeros(1,length(B));

rng('default')
s = rng;
x = rand(1,3);

rng(1,'philox')
xnew = rand(1,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% train data %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Unit 1

for i=1:7
    Y1 = Y1 + 1/(2^i)*sin(2*pi*(2^(2+i)).* A/500);
    if i>=5
        Y1 = Y1 + 1/(2^i)*sin(2*pi*(2^(2+i) * (1+0.01*(x(i-4)-0.5))).* A/500);
    end
end

for i=2:2:8
    Y2 = Y2 + 1/(2^i)*sin(2*pi*(2^(2+i)).*A/500);
    if i>=6
        Y2 = Y2 + 1/(2^i)*cos(2*pi*(2^(2+i) * (1+0.01*(xnew(i-5)-0.5)) ).*A/500);
    end
end

P = linspace(1, 19, 10); % period
for i = 1:length(P)
    rng(i);
    rand_i = rand(1, length(A));
    bn = 2./P(i); % magnitude
    bnx = bn * sin(P(i)*A./(4*pi));
    if i < 5
        Y3 = Y3 + bnx.*(1 + 0.01*(0.5 - rand_i));
    else
        Y3 = Y3 + bnx + 0.3*(0.5 - rand_i);
    end
end


%% Unit 2

Y4(tdel1+1:end) = 0.5*Y1(1:end-tdel1);

Y5(tdel1+1:end) = 0.15*Y1(1:end-tdel1) + 0.85*Y2(1:end-tdel1);

rng(2)
Y6 = 3+normrnd(0,0.1,1,length(A));


%% Unit 3

Y7(tdel1+1:end) = 0.5*Y1(1:end-tdel1) + 0.5*Y2(1:end-tdel1) + 0.05*Y3(1:end-tdel1);

Y8(tdel1+1:end) = 0.2*Y2(1:end-tdel1) + 0.3*Y3(1:end-tdel1);

Y9(tdel1+1:end) = 0.5*Y2(1:end-tdel1) + 0.5*Y7(tdel1+1:end);



%% Unit 4

Y10(tdel1+tdel2+1:end) = 0.5*Y4(tdel1+1:end-tdel2) + 0.5*Y7(tdel1+1:end-tdel2) + 0.1*Y8(tdel1+1:end-tdel2);

Y11(tdel1+tdel2+1:end) = 0.5*Y4(tdel1+1:end-tdel2) + 0.5*Y5(tdel1+1:end-tdel2) + 0.5*Y6(tdel1+1:end-tdel2)  + 0.5*Y7(tdel1+1:end-tdel2) + 0.5*Y8(tdel1+1:end-tdel2);

Y12(tdel1+tdel2+1:end) = 0.5*Y6(tdel1+1:end-tdel2) + 0.5*Y7(tdel1+1:end-tdel2) + 0.5*Y9(tdel1+1:end-tdel2);





%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% test data %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Unit 1

for i=1:7
    Z1 = Z1 + 1/(2^i)*sin(2*pi*(2^(2+i)).* B/500);
    if i>=5
        Z1 = Z1 + 1/(2^i)*sin(2*pi*(2^(2+i) * (1+0.01*(x(i-4)-0.5))).* B/500);
    end
end
% case1 : V1(frequency fault (period of the signal decreases))
if err_case == 1
    Z1_err = zeros(1,length(B));
    for i=1:7
        Z1_err = Z1_err + 1/(2^i)*sin(2*pi*(2^(2+i)).* B/250);
        if i>=5
            Z1_err = Z1_err + 1/(2^i)*sin(2*pi*(2^(2+i) * (1+0.01*(x(i-4)-0.5))).* B/250);
        end
    end
    Z1(10500:end) = Z1_err(10500-205:end-205);
end

for i=2:2:8
    Z2 = Z2 + 1/(2^i)*sin(2*pi*(2^(2+i)).*B/500);
    if i>=6
        Z2 = Z2 + 1/(2^i)*cos(2*pi*(2^(2+i) * (1+0.01*(xnew(i-5)-0.5)) ).*B/500);
    end
end
% case2 : V2(phase change fault (signal shape changes))
if err_case == 2
    Z2_err = zeros(1,length(B));
    for i=2:1:3
        Z2_err = Z2_err + 1/(2^i)*sin(2*pi*(2^(2+i)).*B/500);
    end
    Z2_err = Z2_err + 1/(2^3)*sin(2*pi*(2^(2+4)).*B/500);
    Z2(10500:end) = Z2_err(10500:end);
end

P = linspace(1, 19, 10); % period
for i = 1:length(P)
    rng(i);
    rand_i = rand(1, length(B));
    bn = 2./P(i); % magnitude
    bnx = bn * sin(P(i)*B./(4*pi));
    if i < 5
        Z3 = Z3 + bnx.*(1 + 0.01*(0.5 - rand_i));
    else
        Z3 = Z3 + bnx + 0.3*(0.5 - rand_i);
    end
end
% case3 : V3(square wave fault (for the square wave fault, the switch is disabled, and only one signal type is sent))
if err_case == 3
    for i = 1:length(P)
        rng(i);
        rand_i = rand(1, length(B)-10500);
        bn = M(i);
        bnx = bn * sin(P(i)*B(10501:end)./(4*pi));
        if i < 5
            Z3(10501:end) = Z3(10501:end) - bnx.*(1 + noise*(0.5 - rand_i));
        else
            Z3(10501:end) = Z3(10501:end) - bnx + 0.3*(0.5 - rand_i);
        end
    end
    Z3(10501:end) = Z3(10501:end) + mean(abs(Z3(1:10501)));
end


%% Unit 2

Z4(tdel1+1:end) = 0.5*Z1(1:end-tdel1);

Z5(tdel1+1:end) = 0.15*Z1(1:end-tdel1) + 0.85*Z2(1:end-tdel1);

rng(19970617)
Z6 = 3+normrnd(0,0.1,1,length(B));
% case4 : V6(noise increment fault)
if err_case == 4
    rng(19970617)
    Z6(10501:end) = 3 + 2.5*normrnd(0,0.1,1,length(B)-10500);
end


%% Unit 3

Z7(tdel1+1:end) = 0.5*Z1(1:end-tdel1) + 0.5*Z2(1:end-tdel1) + 0.05*Z3(1:end-tdel1);
% case5 : V7(exponentially decreasing amplitude fault)
if err_case == 5
    for i = 10500:1:length(B)
        Z7(i) = Z7(i)/exp(0.0008*(i-10500));
    end
end

Z8(tdel1+1:end) = 0.2*Z2(1:end-tdel1) + 0.3*Z3(1:end-tdel1);

Z9(tdel1+1:end) = 0.5*Z2(1:end-tdel1) + 0.5*Z7(tdel1+1:end);


%% Unit 4

Z10(tdel1+tdel2+1:end) = 0.5*Z4(tdel1+1:end-tdel2) + 0.5*Z7(tdel1+1:end-tdel2) + 0.1*Z8(tdel1+1:end-tdel2);

Z11(tdel1+tdel2+1:end) = 0.5*Z4(tdel1+1:end-tdel2) + 0.5*Z5(tdel1+1:end-tdel2) + 0.5*Z6(tdel1+1:end-tdel2)  + 0.5*Z7(tdel1+1:end-tdel2) + 0.5*Z8(tdel1+1:end-tdel2);

Z12(tdel1+tdel2+1:end) = 0.5*Z6(tdel1+1:end-tdel2) + 0.5*Z7(tdel1+1:end-tdel2) + 0.5*Z9(tdel1+1:end-tdel2);
% case6 : V12(ramp linear increase fault)
if err_case == 6
    for i = 10500:1:length(B)
        Z12(i) = Z12(i) + 0.001*(i-10500);
    end
end




%% data sum & add noise

trsum = [Y1' Y2' Y3' Y4' Y5' Y6' Y7' Y8' Y9' Y10' Y11' Y12'];
tesum = [Z1' Z2' Z3' Z4' Z5' Z6' Z7' Z8' Z9' Z10' Z11' Z12'];
tr_wonoi = trsum(501:end,:);
te_wonoi = tesum(501:end,:);

fttrnoi = zeros(size(tr_wonoi));
fttenoi = zeros(size(te_wonoi));
rng(960110);
rand_noi = rand(1, 12);
rng(seednum + 100); % Rearrangement seed (w.r.t. seed of rng(seednum + 100))
rand_tridx = randperm(size(tr_wonoi, 1));
rand_teidx = randperm(size(te_wonoi, 1));
trnoi_mat = [];
tenoi_mat = [];
for j = 1:12
    rng(960110);
    fttrnoi(:,j) = normrnd(0,rand_noi(j),size(tr_wonoi,1),1);
    fttenoi(:,j) = normrnd(0,rand_noi(j),size(te_wonoi,1),1);
    trnoi = fttrnoi(:, j);
    tenoi = fttenoi(:, j);
    trnoi_mat(:, j) = trnoi(rand_tridx); 
    tenoi_mat(:, j) = tenoi(rand_teidx);
end

noisc = 0.1; % 0.1(default noise)
traindata = tr_wonoi + noisc*trnoi_mat;
testdata = te_wonoi + noisc*tenoi_mat;






%% Output

if ws == 1
    filenametr = strcat('train_s',num2str(seednum),'.xlsx');
    filenamete = strcat('test_case',num2str(err_case),'_s',num2str(seednum),'.xlsx');
    writematrix(traindata,filenametr,'Sheet',1)
    writematrix(testdata,filenamete,'Sheet',1)
end

%%
if tgs == 1
    figure()
    for i = 1:12
        subplot(12,1,i)
        plot(traindata(:,i))
        if i == 1
            title("train data")
        end
    end
    figure()
    for i = 1:12
        subplot(12,1,i)
        plot(testdata(:,i))
        if i == 1
            title("test data")
        end
    end
end

%%
if egs == 1
    % raw each
    for i = 1:12
        figure()
        plot(testdata(:,i))
    end
end
