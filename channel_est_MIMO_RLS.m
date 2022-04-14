
function MSE = channel_est_MIMO_RLS(Ns,Nd,snr_db,L,lambda)

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
H_RLS = zeros(Nd,Ns);
p = eye(Ns);

for i=1:L
e = D(:,i) - H_RLS*S(:,i);    
k = S(:,i)'*p/(lambda+S(:,i)'*p*S(:,i));
H_RLS = H_RLS + e*k;
p = (p - p*S(:,i)*k)/lambda;
end

MSE = ((norm(H-H_RLS))^2);