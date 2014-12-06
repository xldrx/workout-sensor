Acc1 =        load('befShData8Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagAcc.mat');
VelAcc1 =     load('befShData8Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagVelAcc.mat');
VelAccJerk1 = load('befShData8Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagVelAccJerk.mat');
Vel1 =        load('befShData8Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagVel.mat');
Jerk1 =       load('befShData8Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagJerk.mat');


Acc2 =        load('befShData16Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagAcc.mat');
VelAcc2 =     load('befShData16Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagVelAcc.mat');
VelAccJerk2 = load('befShData16Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagVelAccJerk.mat');
Vel2 =        load('befShData16Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagVel.mat');
Jerk2 =       load('befShData16Winsz8States2Gaussians1Maxjump2RepeatTrain100Iter-MagJerk.mat');

Acc3 =        load('befShData16Winsz16States2Gaussians1Maxjump2RepeatTrain100Iter-MagAcc.mat');
VelAcc3 =     load('befShData16Winsz16States2Gaussians1Maxjump2RepeatTrain100Iter-MagVelAcc.mat');
VelAccJerk3 = load('befShData16Winsz16States2Gaussians1Maxjump2RepeatTrain100Iter-MagVelAccJerk.mat');
Vel3 =        load('befShData16Winsz16States2Gaussians1Maxjump2RepeatTrain100Iter-MagVel.mat');
Jerk3 =       load('befShData16Winsz16States2Gaussians1Maxjump2RepeatTrain100Iter-MagJerk.mat');

Acc4 =        load('befShData16Winsz16States4Gaussians1Maxjump2RepeatTrain100Iter-MagAcc.mat');
VelAcc4 =     load('befShData16Winsz16States4Gaussians1Maxjump2RepeatTrain100Iter-MagVelAcc.mat');
VelAccJerk4 = load('befShData16Winsz16States4Gaussians1Maxjump2RepeatTrain100Iter-MagVelAccJerk.mat');
Vel4 =        load('befShData16Winsz16States4Gaussians1Maxjump2RepeatTrain100Iter-MagVel.mat');
Jerk4 =       load('befShData16Winsz16States4Gaussians1Maxjump2RepeatTrain100Iter-MagJerk.mat');
%% Plots bar graphs by Effort Factor
% figure
% 
% subplot(3,1,1)
% f1Vel1 = [Vel1.hmmBEF.F1{1} ; Vel1.hmmBEF.F1{2} ; Vel1.hmmBEF.F1{3}];
% bar(f1Vel1);
% title('Velocity: Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,2)
% f1Vel2 = [Vel2.hmmBEF.F1{1} ; Vel2.hmmBEF.F1{2} ; Vel2.hmmBEF.F1{3}];
% bar(f1Vel2);
% title('Velocity: Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,3)
% f1Vel3 = [Vel3.hmmBEF.F1{1} ; Vel3.hmmBEF.F1{2} ; Vel3.hmmBEF.F1{3}];
% bar(f1Vel3);
% title('Velocity: Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,4)
% f1Vel4 = [Vel4.hmmBEF.F1{1} ; Vel4.hmmBEF.F1{2} ; Vel4.hmmBEF.F1{3}];
% bar(f1Vel4);
% title('Velocity: Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures')
% 
% legend('Indulging', 'Fighting')
% 
% figure
% 
% subplot(3,1,1)
% f1Acc1 = [Acc1.hmmBEF.F1{1} ; Acc1.hmmBEF.F1{2} ; Acc1.hmmBEF.F1{3}];
% bar(f1Acc1);
% title('Acceleration: Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,2)
% f1Acc2 = [Acc2.hmmBEF.F1{1} ; Acc2.hmmBEF.F1{2} ; Acc2.hmmBEF.F1{3}];
% bar(f1Acc2);
% title('Acceleration: Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,3)
% f1Acc3 = [Acc3.hmmBEF.F1{1} ; Acc3.hmmBEF.F1{2} ; Acc3.hmmBEF.F1{3}];
% bar(f1Acc3);
% title('Acceleration: Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,4)
% f1Acc4 = [Acc4.hmmBEF.F1{1} ; Acc4.hmmBEF.F1{2} ; Acc4.hmmBEF.F1{3}];
% bar(f1Acc4);
% title('Acceleration: Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures')
% 
% legend('Indulging', 'Fighting')
% 
% figure
% 
% subplot(3,1,1)
% f1Jerk1 = [Jerk1.hmmBEF.F1{1} ; Jerk1.hmmBEF.F1{2} ; Jerk1.hmmBEF.F1{3}];
% bar(f1Jerk1);
% title('Jerk: Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,2)
% f1Jerk2 = [Jerk2.hmmBEF.F1{1} ; Jerk2.hmmBEF.F1{2} ; Jerk2.hmmBEF.F1{3}];
% bar(f1Jerk2);
% title('Jerk: Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,3)
% f1Jerk3 = [Jerk3.hmmBEF.F1{1} ; Jerk3.hmmBEF.F1{2} ; Jerk3.hmmBEF.F1{3}];
% bar(f1Jerk3);
% title('Jerk: Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,4)
% f1Jerk4 = [Jerk4.hmmBEF.F1{1} ; Jerk4.hmmBEF.F1{2} ; Jerk4.hmmBEF.F1{3}];
% bar(f1Jerk4);
% title('Jerk: Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures')
% 
% legend('Indulging', 'Fighting')
% 
% figure
% 
% subplot(3,1,1)
% f1VelAcc1 = [VelAcc1.hmmBEF.F1{1} ; VelAcc1.hmmBEF.F1{2} ; VelAcc1.hmmBEF.F1{3}];
% bar(f1VelAcc1);
% title('Velocity and Acceleration: Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,2)
% f1VelAcc2 = [VelAcc2.hmmBEF.F1{1} ; VelAcc2.hmmBEF.F1{2} ; VelAcc2.hmmBEF.F1{3}];
% bar(f1VelAcc2);
% title('Velocity and Acceleration: Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,3)
% f1VelAcc3 = [VelAcc3.hmmBEF.F1{1} ; VelAcc3.hmmBEF.F1{2} ; VelAcc3.hmmBEF.F1{3}];
% bar(f1VelAcc3);
% title('Velocity and Acceleration: Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,4)
% f1VelAcc4 = [VelAcc4.hmmBEF.F1{1} ; VelAcc4.hmmBEF.F1{2} ; VelAcc4.hmmBEF.F1{3}];
% bar(f1VelAcc4);
% title('Velocity and Acceleration: Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures')
% 
% legend('Indulging', 'Fighting')
% 
% figure
% 
% subplot(3,1,1)
% f1VelAccJerk1 = [VelAccJerk1.hmmBEF.F1{1} ; VelAccJerk1.hmmBEF.F1{2} ; VelAccJerk1.hmmBEF.F1{3}];
% bar(f1VelAccJerk1);
% title('Velocity, Accleration and Jerk: Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,2)
% f1VelAccJerk2 = [VelAccJerk2.hmmBEF.F1{1} ; VelAccJerk2.hmmBEF.F1{2} ; VelAccJerk2.hmmBEF.F1{3}];
% bar(f1VelAccJerk2);
% title('Velocity, Accleration and Jerk: Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,3)
% f1VelAccJerk3 = [VelAccJerk3.hmmBEF.F1{1} ; VelAccJerk3.hmmBEF.F1{2} ; VelAccJerk3.hmmBEF.F1{3}];
% bar(f1VelAccJerk3);
% title('Velocity, Accleration and Jerk: Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures')
% subplot(3,1,4)
% f1VelAccJerk4 = [VelAccJerk4.hmmBEF.F1{1} ; VelAccJerk4.hmmBEF.F1{2} ; VelAccJerk4.hmmBEF.F1{3}];
% bar(f1VelAccJerk4);
% title('Velocity, Accleration and Jerk: Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures')
% 
% legend('Indulging', 'Fighting')
%% Plot bar graphs by HMM parameters
figure

subplot(3,1,1)
f1Weight = [Vel1.hmmBEF.F1{1} ; Vel2.hmmBEF.F1{1} ; Vel3.hmmBEF.F1{1} ; Vel4.hmmBEF.F1{1}];
bar(f1Weight);
title('Velocity Weight')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,2)
f1Space = [Vel1.hmmBEF.F1{2} ; Vel2.hmmBEF.F1{2} ; Vel3.hmmBEF.F1{2} ; Vel4.hmmBEF.F1{2}];
bar(f1Space);
title('Velocity Space')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,3)
f1Time = [Vel1.hmmBEF.F1{3} ; Vel2.hmmBEF.F1{3} ; Vel3.hmmBEF.F1{3} ; Vel4.hmmBEF.F1{3}];
bar(f1Time);
title('Velocity Time')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})

legend('Indulging', 'Fighting') 


figure

subplot(3,1,1)
f1Weight = [Acc1.hmmBEF.F1{1} ; Acc2.hmmBEF.F1{1} ; Acc3.hmmBEF.F1{1} ; Acc4.hmmBEF.F1{1}];
bar(f1Weight);
title('Acceleration Weight')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,2)
f1Space = [Acc1.hmmBEF.F1{2} ; Acc2.hmmBEF.F1{2} ; Acc3.hmmBEF.F1{2} ; Acc4.hmmBEF.F1{2}];
bar(f1Space);
title('Acceleration Space')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,3)
f1Time = [Acc1.hmmBEF.F1{3} ; Acc2.hmmBEF.F1{3} ; Acc3.hmmBEF.F1{3} ; Acc4.hmmBEF.F1{3}];
bar(f1Time);
title('Acceleration Time')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})

legend('Indulging', 'Fighting') 


figure

subplot(3,1,1)
f1Weight = [Jerk1.hmmBEF.F1{1} ; Jerk2.hmmBEF.F1{1} ; Jerk3.hmmBEF.F1{1} ; Jerk4.hmmBEF.F1{1}];
bar(f1Weight);
title('Jerk Weight')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,2)
f1Space = [Jerk1.hmmBEF.F1{2} ; Jerk2.hmmBEF.F1{2} ; Jerk3.hmmBEF.F1{2} ; Jerk4.hmmBEF.F1{2}];
bar(f1Space);
title('Jerk Space')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,3)
f1Time = [Jerk1.hmmBEF.F1{3} ; Jerk2.hmmBEF.F1{3} ; Jerk3.hmmBEF.F1{3} ; Jerk4.hmmBEF.F1{3}];
bar(f1Time);
title('Jerk Time')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})

legend('Indulging', 'Fighting') 

figure

subplot(3,1,1)
f1Weight = [VelAcc1.hmmBEF.F1{1} ; VelAcc2.hmmBEF.F1{1} ; VelAcc3.hmmBEF.F1{1} ; VelAcc4.hmmBEF.F1{1}];
bar(f1Weight);
title('Velocity and Acceleration Weight')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,2)
f1Space = [VelAcc1.hmmBEF.F1{2} ; VelAcc2.hmmBEF.F1{2} ; VelAcc3.hmmBEF.F1{2} ; VelAcc4.hmmBEF.F1{2}];
bar(f1Space);
title('Velocity and Acceleration Space')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,3)
f1Time = [VelAcc1.hmmBEF.F1{3} ; VelAcc2.hmmBEF.F1{3} ; VelAcc3.hmmBEF.F1{3} ; VelAcc4.hmmBEF.F1{3}];
bar(f1Time);
title('Velocity and Acceleration Time')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
legend('Indulging', 'Fighting') 

figure

subplot(3,1,1)
f1Weight = [VelAccJerk1.hmmBEF.F1{1} ; VelAccJerk2.hmmBEF.F1{1} ; VelAccJerk3.hmmBEF.F1{1} ; VelAccJerk4.hmmBEF.F1{1}];
bar(f1Weight);
title('Velocity, Acceleration and Jerk Weight')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,2)
f1Space = [VelAccJerk1.hmmBEF.F1{2} ; VelAccJerk2.hmmBEF.F1{2} ; VelAccJerk3.hmmBEF.F1{2} ; VelAccJerk4.hmmBEF.F1{2}];
bar(f1Space);
title('Velocity, Acceleration and Jerk Space')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})
subplot(3,1,3)
f1Time = [VelAccJerk1.hmmBEF.F1{3} ; VelAccJerk2.hmmBEF.F1{3} ; VelAccJerk3.hmmBEF.F1{3} ; VelAccJerk4.hmmBEF.F1{3}];
bar(f1Time);
title('Velocity, Acceleration and Jerk Time')
set(gca,'XTICKLabel',{'Window Size of 8, 8 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 8 Hidden States, 2 Gaussian Mixtures',...
    'Window Size of 16, 16 Hidden States, 2 Gaussian Mixtures', 'Window Size of 16, 16 Hidden States, 4 Gaussian Mixtures'})

legend('Indulging', 'Fighting')


