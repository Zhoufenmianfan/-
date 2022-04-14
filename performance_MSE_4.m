 clc,clear,close all;
% 这里的MSE是信道H和估计的H之间的MSE
rep = 1000;

Ns = 2;
Nd = 3;
snr = 20;
L = 0:2:100;%每隔2个symbol才进行一次信道的估计
% 
% u1 = 0.05;
% u2 = 0.1;
% u3 = 0.2;
% 
% lambda1=1;
% lambda2=0.5;
% lambda3=0.2;

mu1=0.5;
mu2=0.8;

gamma1=0.02;
gamma2=0.10;
gamma3=0.15;
gamma4=0.20;
gamma5=0.30;



% a1=0.8;
% a2=0.5;
% 每一列表示的都是同一个时刻的不同次数的仿真MSE
for i = 1:length(L)
  waitbar(i/length(L));     
  for j = 1:rep
%   [MSE1_1(i,j)] = channel_est_MIMO_LMS(Ns,Nd,snr,L(i),u1);
%   [MSE1_2(i,j)] = channel_est_MIMO_LMS(Ns,Nd,snr,L(i),u2);
%   [MSE1_3(i,j)] = channel_est_MIMO_LMS(Ns,Nd,snr,L(i),u3);
%   [MSE2_1(i,j)] = channel_est_MIMO_LS(Ns,Nd,snr,L(i),lambda1);
%   [MSE2_2(i,j)] = channel_est_MIMO_LS(Ns,Nd,snr,L(i),lambda2);
%   [MSE2_3(i,j)] = channel_est_MIMO_LS(Ns,Nd,snr,L(i),lambda3);
%   [MSE3_1(i,j)]=channel_est_MIMO_RLS(Ns,Nd,snr,L(i),lambda1);
%   [MSE3_2(i,j)]=channel_est_MIMO_RLS(Ns,Nd,snr,L(i),lambda2);
  [MSE4_1(i,j)]=channel_est_MIMO_NLMS(Ns,Nd,snr,L(i),mu1);
%   [MSE4_2(i,j)]=channel_est_MIMO_NLMS(Ns,Nd,snr,L(i),mu2);
%   [MSE5_1(i,j)]=channel_est_MIMO_LMS_Newton(Ns,Nd,snr,L(i),mu1,a1);
%   [MSE5_2(i,j)]=channel_est_MIMO_LMS_Newton(Ns,Nd,snr,L(i),mu2,a1);
%   [MSE5_3(i,j)]=channel_est_MIMO_LMS_Newton(Ns,Nd,snr,L(i),mu2,a2);
%   [MSE6_1(i,j)]=channel_est_MIMO_LMS_AP(Ns,Nd,snr,L(i),mu2,0);
%   [MSE6_2(i,j)]=channel_est_MIMO_LMS_AP(Ns,Nd,snr,L(i),mu2,1);
%   [MSE6_3(i,j)]=channel_est_MIMO_LMS_AP(Ns,Nd,snr,L(i),mu2,2);
  [MSE7_1(i,j),ratio1(i,j)] = channel_est_MIMO_SM_NLMS(Ns,Nd,snr,L(i),gamma1);
  [MSE7_2(i,j),ratio2(i,j)] = channel_est_MIMO_SM_NLMS(Ns,Nd,snr,L(i),gamma2);
  [MSE7_3(i,j),ratio3(i,j)] = channel_est_MIMO_SM_NLMS(Ns,Nd,snr,L(i),gamma3);
  [MSE7_4(i,j),ratio4(i,j)] = channel_est_MIMO_SM_NLMS(Ns,Nd,snr,L(i),gamma4);
  [MSE7_5(i,j),ratio5(i,j)] = channel_est_MIMO_SM_NLMS(Ns,Nd,snr,L(i),gamma5);
  end
end

% semilogy(L,mean(MSE1_1,2),'+-');
% hold on;
% semilogy(L,mean(MSE1_2,2),'.-');
% semilogy(L,mean(MSE1_3,2),':');
% 
% semilogy(L,mean(MSE2_1,2),'*-');
% semilogy(L,mean(MSE2_2,2),'x-');
% semilogy(L,mean(MSE2_3,2),'s-');
% 
% semilogy(L,mean(MSE3_1,2),'d-');
% semilogy(L,mean(MSE3_2,2),'-');
% 
semilogy(L,mean(MSE4_1,2),'-.');
hold on
% semilogy(L,mean(MSE4_2,2),'--');
% 
% semilogy(L,mean(MSE5_1,2),'*-');
% semilogy(L,mean(MSE5_2,2),'x-');
% semilogy(L,mean(MSE5_3,2),'s-');

% semilogy(L,mean(MSE6_1,2),'*-');
% semilogy(L,mean(MSE6_2,2),'x-');
% semilogy(L,mean(MSE6_3,2),'s-');
semilogy(L,mean(MSE7_1,2),'*-');
% hold on
semilogy(L,mean(MSE7_2,2),'x-');
semilogy(L,mean(MSE7_3,2),'s-');
semilogy(L,mean(MSE7_4,2),'--');
semilogy(L,mean(MSE7_5,2),'d-');
leg1=strcat("NLMS:mu=",num2str(mu1));
% leg2=strcat("NLMS:mu=",num2str(mu2));
R1=mean(mean(ratio1(2:end,:)));
R2=mean(mean(ratio2(2:end,:)));
R3=mean(mean(ratio3(2:end,:)));
R4=mean(mean(ratio4(2:end,:)));
R5=mean(mean(ratio5(2:end,:)));
leg2=strcat("SM-NLMS:gamma=",num2str(gamma1),"；","更新率为： ",num2str(R1));
leg3=strcat("SM-NLMS:gamma=",num2str(gamma2),"；","更新率为： ",num2str(R2));
leg4=strcat("SM-NLMS:gamma=",num2str(gamma3),"；","更新率为： ",num2str(R3));
leg5=strcat("SM-NLMS:gamma=",num2str(gamma4),"；","更新率为： ",num2str(R4));
leg6=strcat("SM-NLMS:gamma=",num2str(gamma5),"；","更新率为： ",num2str(R5));

legend(leg1,leg2,leg3,leg4,leg5,leg6);
xlabel('Received Symbols');
ylabel('MSE');
% grid on;
% u越小，收敛越慢，但是稳态性能更好，但是有时候也不能太小，否则还没有收敛，信道就变化；u越大，收敛越快，但是稳态性能更差；但是u不能超过一个范围；