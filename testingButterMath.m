a=[(1/1)^8 0 0 0 0 0 0 0 1];
b=[1];
[resids, poles, k]=residue(b,a);

sys1=tf(b,a);
freqs(b,a,(-pi:(2*pi/1000):pi))
[numd,dend]=bilinear(cell2mat(sys1.Numerator), cell2mat(sys1.Denominator),1);
figure(1);
freqz(numd,dend,1000);

%find all LHP poles of CT magnitude squared function
butterPoles=zeros(1,4);
a=zeros(1,4);
b=zeros(1,4);
for i=1:2
    angle=pi+pi/10+(i-1)*pi/5;
    a(i)=(cos(angle));
    a(i+2)=(cos(angle));  
    b(i)=sin(angle);
    b(i+2)=-sin(angle);
end
butterPoles=complex(a,b);

poles=transpose(butterPoles);

denominator=poly(butterPoles);
numerator=[1];

[numerator_d_lp,denominator_d_lp]=bilinear(numerator,denominator,0.5);

figure(2)
freqz(numerator_d_lp, denominator_d_lp);

sys=tf(numerator_d_lp, denominator_d_lp,-1);
figure(3)
pzmap(sys)

%highpass butterworth filter

