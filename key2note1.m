function X = key2note1(X, keynum, starting_pulse, dur_in_pulses, fs, BPM, PPQ)
beats_per_sec=BPM/60;
sec_per_beat=1/(beats_per_sec);
sec_per_pulses=sec_per_beat/PPQ;
dur1=dur_in_pulses*sec_per_pulses;
tt = 1/fs:(1/fs):dur1;
freq = keynum;%<=============== fill in this line

sig= cos(2*pi*freq*tt);
A = linspace(0, 0.6, (length(sig)*0.2)); %rise 20% of signal
D = linspace(0.6, 0.5,(length(sig)*0.05)); %drop of 5% of signal
S = linspace(0.5, 0.5,(length(sig)*0.4)); %delay of 40% of signal
R = linspace(0.5, 0,(length(sig)*0.35)); %drop of 35% of signal

ADSR = [A D S R] ; %make a matrix

dif = length(sig) - length(ADSR); %find out the difference

x = cat(2, ADSR, zeros(1,dif)); %concatenates a horrizontal (2) ADSR + the difference of ADSR and the signal

xx = sig .* x; %times them together
Start=floor((starting_pulse*sec_per_pulses)*fs)+1;
End=Start+length(xx);
X(Start+1:End)=X(Start+1:End)+xx;
end