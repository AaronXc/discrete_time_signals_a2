z = tf('z',1/(2*pi*10000));

H\textunderscore 0 = 1/2*(1+z^(-1));
H\textunderscore 1 = 1/2*(1-z^(-1));

G\textunderscore 0 = 1/2*(1+z^(-1));
G\textunderscore 1 = 1/2*(-1+z^(-1));

identity\textunderscore 0 = H\textunderscore 0*G\textunderscore 0;
identity\textunderscore 1 = H\textunderscore 1*G\textunderscore 1;

frequencies=(-pi:(2*pi/1000):pi);
frequencies=frequencies(1:1000);
frequencies2=exp(j.*frequencies);
identity\textunderscore 0\textunderscore resp = freqresp(identity\textunderscore 0, frequencies2);
identity\textunderscore 1\textunderscore resp = freqresp(identity\textunderscore 1, frequencies2);

fignum=1;
mag1=abs(identity\textunderscore 1\textunderscore resp);
phase1=angle(identity\textunderscore 1\textunderscore resp);
signals1=[transpose(mag1(:)); transpose(phase1(:))];
plotResp(2, fignum, 2, 1, signals1, [frequencies; frequencies], [1000 1000], ...
["Overall branch $identity\textunderscore 1$ Magnitude Response", "Overall branch $identity\textunderscore 1$ Phase Response"], ...
["Magnitude Response", "Phase Response"], ...
["Discrete time frequency","Discrete time frequency"],0);
   
fignum=2;
mag0=abs(identity\textunderscore 0\textunderscore resp);
phase0=angle(identity\textunderscore 0\textunderscore resp);
signals0=[transpose(mag0(:)); transpose(phase0(:))];
plotResp(2, fignum, 2, 1, signals0, [frequencies; frequencies], [1000 1000], ...
["Overall branch $identity\textunderscore 0$ Magnitude Response", "Overall branch $identity\textunderscore 0$ Phase Response"], ...
["Magnitude Response", "Phase Response"], ...
["Discrete time frequency","Discrete time frequency"],0);
    
fignum=3;
mag=abs(identity\textunderscore 1\textunderscore resp+identity\textunderscore 0\textunderscore resp);
phase=angle(identity\textunderscore 1\textunderscore resp+identity\textunderscore 0\textunderscore resp);
signals=[transpose(mag(:)); transpose(phase(:))];
plotResp(2, fignum, 2, 1, signals, [frequencies; frequencies], [1000 1000], ...
["Overall Identity Magnitude Response", "Overall Identity Phase Response"], ...
["Magnitude Response", "Phase Response"], ...
["Discrete time frequency","Discrete time frequency"],0);
    
    



