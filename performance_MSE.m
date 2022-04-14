 clc,clear,close all;
% 这里的MSE是信道H和估计的H之间的MSE
rep = 1000;

Ns = 2;
Nd = 3;
snr = 20;
L = 0:2:100;%每隔2个symbol才进行一次信道的估计

u1 = 0.05;
u2 = 0.1;
u3 = 0.2;

lambda1=1;
lambda2=0.5;
lambda3=0.2;

mu1=1;
mu2=0.5;
% 每一列表示的都是同一个时刻的不同次数的仿真MSE
for i = 1:length(L)
  waitbar(i/length(L));     
  for j = 1:rep
  [MSE1_1(i,j)] = channel_est_MIMO_LMS(Ns,Nd,snr,L(i),u1);
  [MSE1_2(i,j)] = channel_est_MIMO_LMS(Ns,Nd,snr,L(i),u2);
  [MSE1_3(i,j)] = channel_est_MIMO_LMS(Ns,Nd,snr,L(i),u3);
  [MSE2_1(i,j)] = channel_est_MIMO_LS(Ns,Nd,snr,L(i),lambda1);
  [MSE2_2(i,j)] = channel_est_MIMO_LS(Ns,Nd,snr,L(i),lambda2);
  [MSE2_3(i,j)] = channel_est_MIMO_LS(Ns,Nd,snr,L(i),lambda3);
  [MSE3_1(i,j)]=channel_est_MIMO_RLS(Ns,Nd,snr,L(i),lambda1);
  [MSE3_2(i,j)]=channel_est_MIMO_RLS(Ns,Nd,snr,L(i),lambda2);
  [MSE4_1(i,j)]=channel_est_MIMO_NLMS(Ns,Nd,snr,L(i),mu1);
  [MSE4_2(i,j)]=channel_est_MIMO_NLMS(Ns,Nd,snr,L(i),mu2);

  
  end
end

semilogy(L,mean(MSE1_1,2),'+-');
hold on;
semilogy(L,mean(MSE1_2,2),'.-');
semilogy(L,mean(MSE1_3,2),':');

semilogy(L,mean(MSE2_1,2),'*-');
semilogy(L,mean(MSE2_2,2),'x-');
semilogy(L,mean(MSE2_3,2),'s-');

semilogy(L,mean(MSE3_1,2),'d-');
semilogy(L,mean(MSE3_2,2),'-');

semilogy(L,mean(MSE4_1,2),'-.');
semilogy(L,mean(MSE4_2,2),'--');

legend("LMS:u=0.05","LMS:u=0.1","LMS:u=0.2","LS:lambda=1","LS:lambda=0.5","LS:lambda=0.2","RLS:lambda=1","RLS:lambda=0.5","NLMS:mu=1","NLMS:mu=0.5");
xlabel('Received Symbols');
ylabel('MSE');
% grid on;
% u越小，收敛越慢，但是稳态性能更好，但是有时候也不能太小，否则还没有收敛，信道就变化；u越大，收敛越快，但是稳态性能更差；但是u不能超过一个范围；