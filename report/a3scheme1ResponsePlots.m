


z = tf('z',1/(2*pi*10000));

H\textunderscore 0 = 1/2*(1+z^(-1));
H\textunderscore 1 = 1/2*(1-z^(-1));

frequencies=(-pi:(2*pi/1000):pi);
frequencies=frequencies(1:1000);
frequencies2=exp(j.*frequencies);
H\textunderscore 0\textunderscore resp  = freqresp(H\textunderscore 0, frequencies2);
H\textunderscore 1\textunderscore resp  = freqresp(H\textunderscore 1, frequencies2);

fignum=1;

plotResp(1, fignum, 1, 1, abs(H\textunderscore 0\textunderscore resp), frequencies, [1000], ...
["Lowpass Filter $H\textunderscore 0$ Magnitude Response"], ...
["Magnitude Response" ], ...
["Discrete time frequency"],0);
	
angle\textunderscore of\textunderscore signal = angle(H\textunderscore 0\textunderscore resp);
	
plotResp(1, fignum+1, 1, 1, angle\textunderscore of\textunderscore signal, frequencies, [1000], ...
["Lowpass Filter $H\textunderscore 0$ Phase Response"], ...
["Phase Response"], ...
["Discrete time frequency"],0);



plotResp(1, fignum+2, 1, 1, abs(H\textunderscore 1\textunderscore resp), frequencies, [1000], ...
["Highpass Filter $H\textunderscore 1$ Magnitude Response"], ...
["Magnitude Response" ], ...
["Discrete time frequency"],0);
	
angle\textunderscore of\textunderscore signal = angle(H\textunderscore 1\textunderscore resp);
	
plotResp(1, fignum+3, 1, 1, angle\textunderscore of\textunderscore signal, frequencies, [1000], ...
["Highpass Filter $H\textunderscore 1$ Phase Response"], ...
["Phase Response"], ...
["Discrete time frequency"],0);


