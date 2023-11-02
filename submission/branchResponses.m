z = tf('z',1/(2*pi*10000));

H_0 = 1/2*(1+z^(-1));
H_1 = 1/2*(1-z^(-1));

G_0 = 1/2*(1+z^(-1));
G_1 = 1/2*(-1+z^(-1));

identity_0 = H_0*G_0;
identity_1 = H_1*G_1;

frequencies=(-pi:(2*pi/1000):pi);
frequencies=frequencies(1:1000);
frequencies2=exp(j.*frequencies);
identity_0_resp = freqresp(identity_0, frequencies2);
identity_1_resp = freqresp(identity_1, frequencies2);

fignum=1;
mag1=abs(identity_1_resp);
phase1=angle(identity_1_resp);
signals1=[transpose(mag1(:)); transpose(phase1(:))];
plotResp(2, fignum, 2, 1, signals1, [frequencies; frequencies], [1000 1000], ...
["Overall branch identity_1 Magnitude Response", "Overall branch identity_1 Phase Response"], ...
["Magnitude Response", "Phase Response"], ...
["Discrete time frequency","Discrete time frequency"],0);
   
fignum=2;
mag0=abs(identity_0_resp);
phase0=angle(identity_0_resp);
signals0=[transpose(mag0(:)); transpose(phase0(:))];
plotResp(2, fignum, 2, 1, signals0, [frequencies; frequencies], [1000 1000], ...
["Overall branch identity_0 Magnitude Response", "Overall branch identity_0 Phase Response"], ...
["Magnitude Response", "Phase Response"], ...
["Discrete time frequency","Discrete time frequency"],0);
    
fignum=3;
mag=abs(identity_1_resp+identity_0_resp);
phase=angle(identity_1_resp+identity_0_resp);
signals=[transpose(mag(:)); transpose(phase(:))];
plotResp(2, fignum, 2, 1, signals, [frequencies; frequencies], [1000 1000], ...
["Overall Identity Magnitude Response", "Overall Identity Phase Response"], ...
["Magnitude Response", "Phase Response"], ...
["Discrete time frequency","Discrete time frequency"],0);
    
    



