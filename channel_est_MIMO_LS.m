
function MSE = channel_est_MIMO_LS(Ns,Nd,snr_db,L,lambda)

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
H_LS = zeros(Nd,Ns);
P=zeros(Nd,Ns);
R=zeros(Ns,Ns);
for i=1:L
%     从i=1到L时刻的循环
P=P+lambda^(L-i)*D(:,i)*S(:,i)';
R=R+lambda^(L-i)*S(:,i)*S(:,i)';

end

H_LS=P*pinv(R);


MSE = ((norm(H-H_LS,'fro'))^2);













