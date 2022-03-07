
function ber = General_MIMO(Ns,Nd,snr_db)
% Ns发送端天线数量
% Nd接收端天线数量
% dB形式的SNR



% Number of symbols
L = 10^4;

% Symbol energy
E = 1;

% Signal-to-noise ratio (SNR) 
snr = exp(snr_db*log(10)/10);

sigma_v_d = sqrt(E*Ns/Nd/snr);


% Channel parameters 

H = complex(randn(Nd,Ns),randn(Nd,Ns))/sqrt(2);
% /sqrt(2)用于归一化


% S = sqrt(E)/sqrt(2)*complex(sign(randint(Ns,L)-0.5),sign(randint(Ns,L)-0.5));

S = sqrt(E)/sqrt(2)*complex(sign(randi(2,Ns,L)-1.5),sign(randi(2,Ns,L)-1.5));

V_d = sigma_v_d/sqrt(2)*complex(randn(Nd,L),randn(Nd,L));

D = H*S + V_d;

% MMSE Detector
R = H*H'+ sigma_v_d^2*eye(Nd);
P = H;
W = inv(R)*P;

S_est = W'*D;

nbe = 0;

   % Counting the number of errors
   for i = 1:(L*Ns)
      if sign(real(S_est(i))) ~= sign(real(S(i)))
         nbe = nbe + 1;
      end
      if sign(imag(S_est(i))) ~= sign(imag(S(i)))
         nbe = nbe + 1;
      end
      
   end   

%Computation of the BER
ber = nbe/(L*Ns*2);














