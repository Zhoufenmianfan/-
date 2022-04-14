
function MSE = channel_est_MIMO_LMS_Newton(Ns,Nd,snr_db,L,mu,a)

% Symbol energy
E = 1;

% Signal-to-noise ratio (SNR) 
snr = exp(snr_db*log(10)/10);
sigma_v_d = sqrt(E*Ns/Nd/snr);

% Channel parameters 
H = complex(randn(Nd,Ns),randn(Nd,Ns))/sqrt(2);

% Training sequence
S = sqrt(E)/sqrt(2)*complex(sign(randi(2,Ns,L)-1.5),sign(randi(2,Ns,L)-1.5));

% Noise
V_d = sigma_v_d/sqrt(2)*complex(randn(Nd,L),randn(Nd,L));


D = H*S + V_d;

% LMS Channel Estimation
H_LMS_N = zeros(Nd,Ns);
Rinv=eye(Ns);

for i=1:L
%     从i=1到L时刻的循环
e=D(:,i)-H_LMS_N*S(:,i);
A=Rinv*S(:,i)*S(:,i)'*Rinv;
B=(1-a)/a+S(:,i)'*Rinv*S(:,i);
Rinv=1/(1-a)*(Rinv-A/B);
H_LMS_N = H_LMS_N + mu*e*S(:,i)'*Rinv;

end
MSE = ((norm(H-H_LMS_N,'fro'))^2);













