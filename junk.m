butterPoles=zeros(1,14);
butterResids=zeros(1,14);
j=1;
for i = 1:length(poles)
   if real(poles(i)) < 0 
    butterPoles(j)=poles(i);
    butterResids(j)=resids(i);
    j=j+1;
   end
end


%attempt to do the ct tf and bilinear by my lonesome
%z = tf('z');
%for i=1:10
%    sys=sys+butterResids(i)/(z-butterPoles(i));
%end

%use matlab functions instead

sys=tf(residue(butterResids,butterPoles,0));
[numd,dend]=bilinear(cell2mat(sys.Numerator), cell2mat(sys.Denominator),1);
%[zd,pd,kd]=bilinear([100000000,100000000,100000000,100000000,100000000,100000000,100000000,100000000,100000000,100000000], butterPoles, 1,1)
%dtButter = tf(numd,dend);
frequencies=(-pi:(2*pi/1000):pi);
frequencies=frequencies(1:1000);
frequencies2=exp(j.*frequencies);
figure(2);
freqz(numd,dend,1000);
%plotResp(1, fignum, 1, 1, abs(transpose(sys_resp)), transpose(w), [1000], ...
%["Butterworth Lowpass Magnitude Response"], ...
%["Magnitude Response" ], ...
%["Discrete time frequency"],0); 

sys=1;
for i=1:14
    sys=sys/(z-butterPoles2(i));
end
figure(2)
freqz(cell2mat(sys.Numerator), cell2mat(sys.Denominator));
figure(3)
pzplot(sys)
sys

[H,W] = freqz(Num,Den,500);
%
%% plot the DT frequency response
%
figure
Line1 = del_2 * ones (size(W));
Line2 = del_1 * ones(size(W));
subplot(211), plot(W/pi,abs(H),W/pi,Line1,W/pi,Line2)
xlabel('DT Frequency (\omega/\pi)'), 
ylabel('Mag response |H(\omega)|')
title('DT Filter Designed by Bilinear Transformation')

%snr is in dB and therefore is a measure of power. The power is slightly
%less than half of the low-frequency power. so dB is a different kind of power, scaled weirdly 
% 
% we are not past the half-power freq of the filter. 
% this is backed up by the LP mag resp, which can be
% inspected at 0.707 magnitude to have a frequency of pi/2