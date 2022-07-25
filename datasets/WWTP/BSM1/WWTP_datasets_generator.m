clear wwtp_d
starttime=14;
stoptime=28;

startindex=max(find(t <= starttime));
stopindex=min(find(t >= stoptime));

time=t(startindex:stopindex);

inx=in(startindex:stopindex,:);
reac1x=reac1(startindex:stopindex,:);
reac2x=reac2(startindex:stopindex,:);
reac3x=reac3(startindex:stopindex,:);
reac4x=reac4(startindex:stopindex,:);
reac5x=reac5(startindex:stopindex,:);
recx=rec(startindex:stopindex,:);
settlerx=settler(startindex:stopindex,:);




wwtp_d(:,1)=inx(:,8);   %O
wwtp_d(:,2)=inx(:,9);   %NO
wwtp_d(:,3)=inx(:,10);  %NH

wwtp_d(:,4)=reac1x(:,8);   %O
wwtp_d(:,5)=reac1x(:,9);   %NO
wwtp_d(:,6)=reac1x(:,10);  %NH

wwtp_d(:,7)=reac2x(:,8);   %O
wwtp_d(:,8)=reac2x(:,9);   %NO
wwtp_d(:,9)=reac2x(:,10);  %NH

wwtp_d(:,10)=reac3x(:,8);   %O
wwtp_d(:,11)=reac3x(:,9);   %NO
wwtp_d(:,12)=reac3x(:,10);  %NH

wwtp_d(:,13)=reac4x(:,8);   %O
wwtp_d(:,14)=reac4x(:,9);   %NO
wwtp_d(:,15)=reac4x(:,10);  %NH

wwtp_d(:,16)=reac5x(:,8);   %O
wwtp_d(:,17)=reac5x(:,9);   %NO
wwtp_d(:,18)=reac5x(:,10);  %NH

wwtp_d(:,19)=settlerx(:,8);   %O
wwtp_d(:,20)=settlerx(:,9);   %NO
wwtp_d(:,21)=settlerx(:,10);  %NH


wwtp_d(:,22)=inx(:,15);
wwtp_d(:,23)=recx(:,15);
wwtp_d(:,24)=settlerx(:,15);
wwtp_d(:,25)=kla5in(1:1345);



figure();
subplot(9,3,1);
plot(time,wwtp_d(:,1));
grid on;
title('inO');

subplot(9,3,2);
plot(time,wwtp_d(:,2));
grid on;
title('inNO');

subplot(9,3,3);
plot(time,wwtp_d(:,3));
grid on;
title('inNH');

subplot(9,3,4);
plot(time,wwtp_d(:,4));
grid on;
title('SO1');

subplot(9,3,5);
plot(time,wwtp_d(:,5));
grid on;
title('SNO1');

subplot(9,3,6);
plot(time,wwtp_d(:,6));
grid on;
title('SNH1');

subplot(9,3,7);
plot(time,wwtp_d(:,7));
grid on;
title('SO2');

subplot(9,3,8);
plot(time,wwtp_d(:,8));
grid on;
title('SNO2');

subplot(9,3,9);
plot(time,wwtp_d(:,9));
grid on;
title('SNH2');

subplot(9,3,10);
plot(time,wwtp_d(:,10));
grid on;
title('SO3');

subplot(9,3,11);
plot(time,wwtp_d(:,11));
grid on;
title('SNO3');

subplot(9,3,12);
plot(time,wwtp_d(:,12));
grid on;
title('SNH3');

subplot(9,3,13);
plot(time,wwtp_d(:,13));
grid on;
title('SO4');

subplot(9,3,14);
plot(time,wwtp_d(:,14));
grid on;
title('SNO4');

subplot(9,3,15);
plot(time,wwtp_d(:,15));
grid on;
title('SNH4');

subplot(9,3,16);
plot(time,wwtp_d(:,16));
grid on;
title('SO5');

subplot(9,3,17);
plot(time,wwtp_d(:,17));
grid on;
title('SNO5');

subplot(9,3,18);
plot(time,wwtp_d(:,18));
grid on;
title('SNH5');

subplot(9,3,19);
plot(time,wwtp_d(:,19));
grid on;
title('eO');

subplot(9,3,20);
plot(time,wwtp_d(:,20));
grid on;
title('eNO');

subplot(9,3,21);
plot(time,wwtp_d(:,21));
grid on;
title('eNH');

subplot(9,3,22);
plot(time,wwtp_d(:,22));
grid on;
title('Qin');

subplot(9,3,23);
plot(time,wwtp_d(:,23));
grid on;
title('Qint');

subplot(9,3,24);
plot(time,wwtp_d(:,24));
grid on;
title('Qe');

subplot(9,3,25);
plot(time,wwtp_d(:,25));
grid on;
title('Kla5in');

wwtp_d = [wwtp_d(2:end,3:23) wwtp_d(2:end,25)];




% filename = 'train_s1.xlsx';
% filename = 'test_case1_s1.xlsx';
% 
% writematrix(wwtp_d,filename,'Sheet',1,'Range','A1')