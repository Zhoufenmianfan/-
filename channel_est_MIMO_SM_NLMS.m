
function [MSE,ratio] = channel_est_MIMO_SM_NLMS(Ns,Nd,snr_db,L,gamma)

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
H_NLMS = zeros(Nd,Ns);
tag=0;
for i=1:L
%     从i=1到L时刻的循环
    e=D(:,i)-H_NLMS*S(:,i);
    if norm(e) > gamma
        tag=tag+1;
        mu=1-gamma/norm(e);
    else
        mu=0;
    end
    H_NLMS = H_NLMS + mu*(e*S(:,i)')/(S(:,i)'*S(:,i));
end
MSE = ((norm(H-H_NLMS,'fro'))^2);
ratio = tag/L;













