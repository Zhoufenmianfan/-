
function ber = General_MIMO(Ns,Nd,snr_db)
% Ns发送端天线数量
% Nd接收端天线数量
% dB形式的SNR



% Number of symbols
L = 10^5;

% Symbol energy
E = 1;

% Signal-to-noise ratio (SNR) 
snr = exp(snr_db*log(10)/10);

sigma_v_d = sqrt(E*Ns/Nd/snr);
% 接收噪声功率，按照天线比例和信噪比，比如4根发送天线同时发送符号能量E，
% 那么2根接收天线同时能就收到的符号能量就是2E（每根天线），这就是2I4O的功率增益


% Channel parameters 

H = complex(randn(Nd,Ns),randn(Nd,Ns))/sqrt(2);
% /sqrt(2)用于归一化,方差的性质var(x1+x2)=var(x1)+var(x2)+cov(x1,x2)
% 这里为了保证H是一个方差为1的复随机数


% S = sqrt(E)/sqrt(2)*complex(sign(randint(Ns,L)-0.5),sign(randint(Ns,L)-0.5));

S = sqrt(E)/sqrt(2)*complex(sign(randi(2,Ns,L)-1.5),sign(randi(2,Ns,L)-1.5));
% 生成虚部实部都是-0.5 或 0.5的随机均匀分布数组，对应四点星座图，一个符号能量是平均为E/4，因此需要分母为根号2，符号能量用共轭相乘表示
V_d = sigma_v_d/sqrt(2)*complex(randn(Nd,L),randn(Nd,L));
% 产生噪声信号，同样也对噪声方差与归一化到sigma_v_d的值，平均的含义就是取期望均值E(X^2+Y^2),XY分别表示噪声的实部和虚部

D = H*S + V_d;

% MMSE Detector
R = H*H'+ 1/snr*eye(Nd);
% H'表示的是共轭转置，由于符号能量E=1就是表示接收信号功率
P = H;
W = inv(R)*P;

S_est = W'*D;
% 表示估计的原始信号
nbe = 0;
% 错误的比特个数
   % Counting the number of errors
   for i = 1:(L*Ns)
      if sign(real(S_est(i))) ~= sign(real(S(i)))
         nbe = nbe + 1;
      end
    % 判断实部比特是否错误（相当于I路）
      if sign(imag(S_est(i))) ~= sign(imag(S(i)))
         nbe = nbe + 1;
      end
    % 判断虚部比特是否错误（相当于Q路）
   end   

%Computation of the BER
ber = nbe/(L*Ns*2);
% 由于一个符号（用复数表示，xy分别表示一个bit），所以误比特率ber=nbe/（总符号个数*2）














