base\textunderscore f = pi/10;
matlabIndexOffset=1;
z = tf('z',1/(2*pi*10000));

H\textunderscore 0 = 1/2*(1+z^(-1));
H\textunderscore 1 = 1/2*(1-z^(-1));

n=[0:1:99]

h\textunderscore 0\textunderscore outputs=zeros(10,100);
h\textunderscore 1\textunderscore outputs=zeros(10,100);
input\textunderscore signals=zeros(10,100);

for i=1:10
    % baseband of discrete time fourier transform of cos(i*base\textunderscore f*n) is pi
    % occuring at +/-omega\textunderscore nought. entirely real, phase is 0 degrees

    % from tables, mthe z transform of cos(i*base\textunderscore f*n) is :
    %   cos(w\textunderscore 0*n)u(n)=(1-cos(w\textunderscore 0)z^(-1))/(1-2cos(w\textunderscore 0)z^(-1)+z^(-2))
    w\textunderscore 0=i*base\textunderscore f
    %input\textunderscore signal=(1-cos(w\textunderscore 0)*z^(-1))/(1-2*cos(w\textunderscore 0)*z^(-1)+z^(-2));

    % a very simple approach: find the output using the difference equation
    % from initial rest.

    input\textunderscore signal=cos(w\textunderscore 0.*n);
    output\textunderscore signal\textunderscore 0=zeros(1,100);
    output\textunderscore signal\textunderscore 1=zeros(1,100);

    output\textunderscore signal\textunderscore 0(1)=input\textunderscore signal(1)*0.5;
    output\textunderscore signal\textunderscore 1(1)=input\textunderscore signal(1)*0.5;

    for j = 2:100

        output\textunderscore signal\textunderscore 0(j)=input\textunderscore signal(j)*0.5+0.5*input\textunderscore signal(j-1);

        output\textunderscore signal\textunderscore 1(j)=input\textunderscore signal(j)*0.5-0.5*input\textunderscore signal(j-1);

    end

    h\textunderscore 0\textunderscore outputs(i,1:100)=output\textunderscore signal\textunderscore 0;
    h\textunderscore 1\textunderscore outputs(i,1:100)=output\textunderscore signal\textunderscore 1;
    input\textunderscore signals(i,1:100)=input\textunderscore signal;
end

for i = 1:10
    plotResp(3, i, 3, 1, [input\textunderscore signals(i,:); h\textunderscore 0\textunderscore outputs(i,:); h\textunderscore 1\textunderscore outputs(i,:)], [n; n; n], [100 100 100], ...
    ["Input to Filter", "Overall $H\textunderscore 0$ Time Response", "Overall $H\textunderscore 1$ Time Response"], ...
    ["Magnitude", "Magnitude", "Magnitude"], ...
    ["Discrete time, n", "Discrete time, n","Discrete time, n"],1);
end

%based on the output of these filters, the first sample of the output
%should be ommitted from the MSE calculation

% ideally, the h\textunderscore 0 filter attenuates all high frequencies
MSE\textunderscore lp=0
ideal\textunderscore val\textunderscore squared=0;
%lowest frequency signal is pi/10=dt frequency, it should be passed
for i = 2:100
    %the causal delay is 1, but the other problem to deal with here is 
    %input signal starting from cos(0) while matlab indexing only allows
    % you to index starting from 1, thus the use of -2 in the ideal cos's argument.

    MSE\textunderscore lp=MSE\textunderscore lp+(cos(pi/10*(i-2))-h\textunderscore 0\textunderscore outputs(1,i))^2;
    ideal\textunderscore val\textunderscore squared=ideal\textunderscore val\textunderscore squared+(cos(pi/10*(i-2)))^2;
end

snr\textunderscore lp = 10*log(ideal\textunderscore val\textunderscore squared/MSE\textunderscore lp);

MSE\textunderscore lp2=0
%assume that the signal's ideal value is just the input attenuated by a factor of 0.01 
ideal\textunderscore val\textunderscore squared2=0;
%highest frequency signal is pi it should be completely attenuated
for i = 2:100
    MSE\textunderscore lp2=MSE\textunderscore lp2+(0.05*cos(pi*(i-matlabIndexOffset))-h\textunderscore 0\textunderscore outputs(10,i))^2;
    ideal\textunderscore val\textunderscore squared2=ideal\textunderscore val\textunderscore squared2+0.00025*(cos(pi*(i-matlabIndexOffset)))^2;
end

snr\textunderscore lp2 = 10*log(ideal\textunderscore val\textunderscore squared2/MSE\textunderscore lp2);

%what is the half-power bandwith of the lowpass filter?

MSE\textunderscore lp3=0
ideal\textunderscore val\textunderscore squared3=0;
delay=6
%from graphs, delay is 1 sample and transient is 1 sample
%medium frequency signal is 3pi/10=dt frequency, it should be passed
for i = 2:100
    MSE\textunderscore lp3=MSE\textunderscore lp3+(cos(3*pi/10*(i-delay-matlabIndexOffset))-h\textunderscore 0\textunderscore outputs(3,i))^2;
    ideal\textunderscore val\textunderscore squared3=ideal\textunderscore val\textunderscore squared3+(cos(3*pi/10*(i-delay-matlabIndexOffset)))^2;
end

snr\textunderscore lp3 = 10*log(ideal\textunderscore val\textunderscore squared3/MSE\textunderscore lp3);
%visually inspect delay from graph
delay=4;
MSE\textunderscore lp4=0;
ideal\textunderscore val\textunderscore squared4=0;
%medium frequency signal is 6pi/10=dt frequency, it is on the high side and should not be passed
for i = 2:100
    MSE\textunderscore lp4=MSE\textunderscore lp4+(0.05*cos(6*pi/10*(i-delay-matlabIndexOffset))-h\textunderscore 0\textunderscore outputs(6,i))^2;
    ideal\textunderscore val\textunderscore squared4=ideal\textunderscore val\textunderscore squared4+0.00025*(cos(6*pi/10*(i-delay-matlabIndexOffset)))^2;
end

snr\textunderscore lp4 = 10*log(ideal\textunderscore val\textunderscore squared4/MSE\textunderscore lp4);


%do the same for the highpass filter

%%

%based on the output of these filters, to evaluate performance, you need to
%account for the transient response of the filter

%based on the time output graphs, the max trasient length is about 40
%samples, there is virtually 0 transient response after that in all graphs

% account for the time delay of the filter in order to compare input and
% output as well

delay=finddelay(input\textunderscore signal, h\textunderscore 1\textunderscore outputs(1,:));
%inspect delay visually from graph
delay=15;
% ideally, the h\textunderscore 1 filter attenuates all high frequencies
MSE\textunderscore hp=0;
ideal\textunderscore val\textunderscore squared=0;
%lowest frequency signal is pi/10=dt frequency, it should not be passed
%assume that the signal's ideal value is just the input attenuated by a factor of 0.05 
for i = 2:100
    MSE\textunderscore hp=MSE\textunderscore hp+(0.05*cos(pi/10*(i-delay-matlabIndexOffset))-h\textunderscore 1\textunderscore outputs(1,i))^2;
    ideal\textunderscore val\textunderscore squared=ideal\textunderscore val\textunderscore squared+0.00025*(cos(pi/10*(i-delay-matlabIndexOffset)))^2;
end

snr\textunderscore hp = 10*log(ideal\textunderscore val\textunderscore squared/MSE\textunderscore hp);


%inspect delay visually from graph
delay=0;

MSE\textunderscore hp2=0;
ideal\textunderscore val\textunderscore squared2=0;
%highest frequency signal is pi it should be completely passed
for i = 2:100
    MSE\textunderscore hp2=MSE\textunderscore hp2+(cos(pi*(i-delay-matlabIndexOffset))-h\textunderscore 1\textunderscore outputs(10,i))^2;
    ideal\textunderscore val\textunderscore squared2=ideal\textunderscore val\textunderscore squared2+(cos(pi*(i-delay-matlabIndexOffset)))^2;
end

snr\textunderscore hp2 = 10*log(ideal\textunderscore val\textunderscore squared2/MSE\textunderscore hp2);

%what is the half-power bandwith of the lowpass filter?

delay=finddelay(input\textunderscore signal, h\textunderscore 1\textunderscore outputs(3,:));

%inspect delay visually from graph
delay=1;

MSE\textunderscore hp3=0;
ideal\textunderscore val\textunderscore squared3=0;
%medium frequency signal is 3pi/10=dt frequency, it is on the low side and should attenuated
for i = 2:100
    MSE\textunderscore hp3=MSE\textunderscore hp3+(0.05*cos(3*pi/10*(i-delay-matlabIndexOffset))-h\textunderscore 1\textunderscore outputs(3,i))^2;
    ideal\textunderscore val\textunderscore squared3=ideal\textunderscore val\textunderscore squared3+0.00025*(cos(3*pi/10*(i-delay-matlabIndexOffset)))^2;
end

snr\textunderscore hp3 = 10*log(ideal\textunderscore val\textunderscore squared3/MSE\textunderscore hp3);

%inspect delay visually from graph
delay=3;

MSE\textunderscore hp4=0;
ideal\textunderscore val\textunderscore squared4=0;
%medium frequency signal is 6pi/10=dt frequency, it is on the high side and should be passed
for i = 2:100
    MSE\textunderscore hp4=MSE\textunderscore hp4+(cos(6*pi/10*(i-delay-matlabIndexOffset))-h\textunderscore 1\textunderscore outputs(3,i))^2;
    ideal\textunderscore val\textunderscore squared4=ideal\textunderscore val\textunderscore squared4+(cos(6*pi/10*(i-delay-matlabIndexOffset)))^2;
end

snr\textunderscore hp4 = 10*log(ideal\textunderscore val\textunderscore squared4/MSE\textunderscore hp4);







