
function MSE = channel_est_MIMO_LMS_SMAP(Ns,Nd,snr_db,n,mu,L)

% Symbol energy
E = 1;

% Signal-to-noise ratio (SNR) 
snr = exp(snr_db*log(10)/10);
sigma_v_d = sqrt(E*Ns/Nd/snr);

% Channel parameters 
H = complex(randn(Nd,Ns),randn(Nd,Ns))/sqrt(2);

% Training sequence
S = sqrt(E)/sqrt(2)*complex(sign(randi(2,Ns,n)-1.5),sign(randi(2,Ns,n)-1.5));

% Noise
V_d = sigma_v_d/sqrt(2)*complex(randn(Nd,n),randn(Nd,n));


D = H*S + V_d;

% LMS Channel Estimation
H_AP = zeros(Nd,Ns);
L=L+1;
for i=1:n
    if i<L
        H_AP = H_AP - mu*(H_AP*S(:,1:i) - D(:,1:i))*S(:,1:i)'/(S(:,1:i)*S(:,1:i)');
    else
        H_AP = H_AP - mu*(H_AP*S(:,(i-L+1):i) - D(:,(i-L+1):i))*S(:,(i-L+1):i)'/(S(:,(i-L+1):i)*S(:,(i-L+1):i)');
    end
end


% 
% for i=L+1:n
% %     从i=1到L时刻的循环
%         A=S(:,i-L:i)*S(:,i-L:i)';
%         e=D(:,i-L:i)-H_AP*S(:,i-L:i);
%         H_AP = H_AP + mu*(e*S(:,i-L:i)')/A;
% end
MSE = ((norm(H-H_AP,'fro'))^2);













