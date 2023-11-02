


z = tf('z',1/(2*pi*10000));

H_0 = 1/2*(1+z^(-1));
H_1 = 1/2*(1-z^(-1));

frequencies=(-pi:(2*pi/1000):pi);
frequencies=frequencies(1:1000);
frequencies2=exp(j.*frequencies);
H_0_resp  = freqresp(H_0, frequencies2);
H_1_resp  = freqresp(H_1, frequencies2);

fignum=1;

plotResp(1, fignum, 1, 1, abs(H_0_resp), frequencies, [1000], ...
["Lowpass Filter H_0 Magnitude Response"], ...
["Magnitude Response" ], ...
["Discrete time frequency"],0);
	
angle_of_signal = angle(H_0_resp);
	
plotResp(1, fignum+1, 1, 1, angle_of_signal, frequencies, [1000], ...
["Lowpass Filter H_0 Phase Response"], ...
["Phase Response"], ...
["Discrete time frequency"],0);



plotResp(1, fignum+2, 1, 1, abs(H_1_resp), frequencies, [1000], ...
["Highpass Filter H_1 Magnitude Response"], ...
["Magnitude Response" ], ...
["Discrete time frequency"],0);
	
angle_of_signal = angle(H_1_resp);
	
plotResp(1, fignum+3, 1, 1, angle_of_signal, frequencies, [1000], ...
["Highpass Filter H_1 Phase Response"], ...
["Phase Response"], ...
["Discrete time frequency"],0);


