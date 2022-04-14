clear all;

rep = 10000;%repetition times
snr = 0:1:10;

ber1=zeros(size(snr,2),rep);
ber2=zeros(size(snr,2),rep);
% ber3=zeros(size(snr,2),rep);
for j = 1:rep
    waitbar(j/rep); 

  for i = 1:length(snr)
      [ber1(i,j)] = General_MIMO_BPSK(2,3,snr(i));
      [ber2(i,j)] = General_MIMO_QPSK(2,3,snr(i));
%       [ber3(i,j)] = Copy_of_General_MIMO_BPSK(2,3,snr(i));
   end
end

semilogy(snr,mean(ber1,2),'g-*');
hold on
semilogy(snr,mean(ber2,2),'b-*');
% semilogy(snr,mean(ber3,2),'r-*');
legend("BPSK","QPSK");
xlabel('SNR');
ylabel('BER');
grid;
