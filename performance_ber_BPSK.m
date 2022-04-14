clear all;

rep = 1000;%repetition times
snr = 0:1:10;

ber=zeros(size(snr,2),rep);

for j = 1:rep
    waitbar(j/rep); 

  for i = 1:length(snr)
      [ber(i,j)] = General_MIMO_BPSK(2,3,snr(i));
   end
end

semilogy(snr,mean(ber,2),'b-*');
xlabel('SNR');
ylabel('BER');
grid;
