a=[(1/1.89077219)^28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
b=[1];
[resids, poles, k]=residue(b,a);

sys1=tf(b,a);
freqs(b,a,(-pi:(2*pi/1000):pi))
[numd,dend]=bilinear(cell2mat(sys1.Numerator), cell2mat(sys1.Denominator),1);
figure(1);
freqz(numd,dend,1000);

%find all LHP poles of CT magnitude squared function
butterPoles=zeros(1,14);
a=zeros(1,14);
b=zeros(1,14);
for i=1:7
    angle=pi+pi/28+(i-1)*pi/14;
    a(i)=1.89077219*(cos(angle));
    a(i+7)=1.89077219*(cos(angle));  
    b(i)=1.89077219*sin(angle);
    b(i+7)=-1.89077219*sin(angle);
end
butterPoles=complex(a,b);

poles=transpose(butterPoles);

denominator=poly(butterPoles);
numerator=[1.89077219^14];

[numerator\textunderscore d\textunderscore lp,denominator\textunderscore d\textunderscore lp]=bilinear(numerator,denominator,1);

figure(2)
freqz(numerator\textunderscore d\textunderscore lp, denominator\textunderscore d\textunderscore lp);

%highpass butterworth filter


[numerator\textunderscore d\textunderscore hp, denominator\textunderscore d\textunderscore hp]=butter(14,1.89077219/pi,'high');

figure(3)
freqz(numerator\textunderscore d\textunderscore hp, denominator\textunderscore d\textunderscore hp);
