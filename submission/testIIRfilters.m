n=[0:1:99]
matlab_index_offset=1;

h_0_outputs=zeros(10,100);
h_1_outputs=zeros(10,100);
input_signals=zeros(10,100);
base_f = pi/10;
for k=1:10
    % baseband of discrete time fourier transform of cos(i*base_f*n) is pi
    % occuring at +/-omega_nought. entirely real, phase is 0 degrees

    % from tables, mthe z transform of cos(i*base_f*n) is :
    %   cos(w_0*n)u(n)=(1-cos(w_0)z^(-1))/(1-2cos(w_0)z^(-1)+z^(-2))
    w_0=k*base_f
    %input_signal=(1-cos(w_0)*z^(-1))/(1-2*cos(w_0)*z^(-1)+z^(-2));

    % a very simple approach: find the output using the difference equation
    % from initial rest.

    input_signal=cos(w_0.*n);
    output_signal_0=zeros(1,100);
    output_signal_1=zeros(1,100);
    
    h_0_outputs(k,1:100)=ccde(input_signal, output_signal_0, numerator_d_lp,denominator_d_lp);
    h_1_outputs(k,1:100)=ccde(input_signal, output_signal_1, numerator_d_hp,denominator_d_hp);
    input_signals(k,1:100)=input_signal;
end

for i = 1:10
    plotResp(3, i, 3, 1, [input_signals(i,:); h_0_outputs(i,:); h_1_outputs(i,:)], [n; n; n], [100 100 100], ...
    ["Input to Filter", "Overall H_0 Time Response", "Overall H_1 Time Response"], ...
    ["Magnitude", "Magnitude", "Magnitude"], ...
    ["Discrete time, n", "Discrete time, n", "Discrete time, n"],1);
end
%%
%based on the output of these filters, to evaluate performance, you need to
%account for the transient response of the filter

%based on the time output graphs, the max trasient length is about 40
%samples, there is virtually 0 transient response after that in all graphs

% account for the time delay of the filter in order to compare input and
% output as well

delay=finddelay(input_signal, h_0_outputs(1,:));
%inspect delay visually from graph
delay=5

% ideally, the h_0 filter attenuates all high frequencies
MSE_lp=0;
ideal_val_squared=0;
%lowest frequency signal is pi/10=dt frequency, it should be passed
for i = 40:100
    
    MSE_lp=MSE_lp+(cos(pi/10*(i-delay-matlab_index_offset))-h_0_outputs(1,i))^2;
    ideal_val_squared=ideal_val_squared+(cos(pi/10*(i-delay-matlab_index_offset)))^2;
end

snr_lp = 10*log(ideal_val_squared/MSE_lp);
%inspect delay visually from graph
delay=0;

delay

MSE_lp2=0;
%assume that the signal's ideal value is just the input attenuated by a factor of 0.05 
ideal_val_squared2=0;
%highest frequency signal is pi it should be completely attenuated
for i = 40:100
    MSE_lp2=MSE_lp2+(0.05*cos(pi*(i-delay-matlab_index_offset))-h_0_outputs(10,i))^2;
    ideal_val_squared2=ideal_val_squared2+0.00025*(cos(pi*(i-delay-matlab_index_offset)))^2;
end

snr_lp2 = 10*log(ideal_val_squared2/MSE_lp2);

%what is the half-power bandwith of the lowpass filter?

delay=finddelay(input_signal, h_0_outputs(3,:));
%observe and manually set time delay from graphs
delay=12

MSE_lp3=0;
ideal_val_squared3=0;
%medium frequency signal is 3pi/10=dt frequency, it should be passed
for i = 40:100
    MSE_lp3=MSE_lp3+(cos(3*pi/10*(i-delay-matlab_index_offset))-h_0_outputs(3,i))^2;
    ideal_val_squared3=ideal_val_squared3+(cos(3*pi/10*(i-delay-matlab_index_offset)))^2;
end

snr_lp3 = 10*log(ideal_val_squared3/MSE_lp3);
%after 40 samlples observe delay (roughly, it is hard to know because
%amplitude is roughly constant at this point)
delay=2;

MSE_lp4=0;
ideal_val_squared4=0;
%medium frequency signal is 6pi/10=dt frequency, it is on the high side and should not be passed
for i = 40:100
    MSE_lp4=MSE_lp4+(0.05*cos(6*pi/10*(i-delay-matlab_index_offset))-h_0_outputs(6,i))^2;
    ideal_val_squared4=ideal_val_squared4+0.00025*(cos(6*pi/10*(i-delay-matlab_index_offset)))^2;
end

snr_lp4 = 10*log(ideal_val_squared4/MSE_lp4);


%%


%based on the output of these filters, to evaluate performance, you need to
%account for the transient response of the filter

%based on the time output graphs, the max trasient length is about 40
%samples, there is virtually 0 transient response after that in all graphs

% account for the time delay of the filter in order to compare input and
% output as well

delay=finddelay(input_signal, h_1_outputs(1,:));
%inspect delay visually from graph
delay=5

% ideally, the h_1 filter attenuates all high frequencies
MSE_hp=0;
ideal_val_squared=0;
%lowest frequency signal is pi/10=dt frequency, it should not be passed
%assume that the signal's ideal value is just the input attenuated by a factor of 0.05 
for i = 40:100
    MSE_hp=MSE_hp+(0.05*cos(pi/10*(i-delay-matlab_index_offset))-h_1_outputs(1,i))^2;
    ideal_val_squared2=ideal_val_squared2+0.00025*(cos(pi/10*(i-delay-matlab_index_offset)))^2;
end

snr_hp = 10*log(ideal_val_squared/MSE_hp);
%inspect delay visually from graph
delay=0;

delay

MSE_hp2=0;

ideal_val_squared2=0;
%highest frequency signal is pi it should be completely passed
for i = 40:100
    MSE_hp2=MSE_hp2+(cos(pi*(i-delay-matlab_index_offset))-h_1_outputs(10,i))^2;
    ideal_val_squared2=ideal_val_squared2+(cos(pi*(i-delay-matlab_index_offset)))^2;
end

snr_hp2 = 10*log(ideal_val_squared2/MSE_hp2);

%what is the half-power bandwith of the lowpass filter?

delay=finddelay(input_signal, h_1_outputs(3,:));

delay=0;

MSE_hp3=0;
ideal_val_squared3=0;
%medium frequency signal is 3pi/10=dt frequency, it is on the low side and should attenuated
for i = 40:100
    MSE_hp3=MSE_hp3+(0.05*cos(3*pi/10*(i-delay-matlab_index_offset))-h_1_outputs(3,i))^2;
    ideal_val_squared3=ideal_val_squared3+0.00025*(cos(3*pi/10*(i-delay-matlab_index_offset)))^2;
end

snr_hp3 = 10*log(ideal_val_squared3/MSE_hp3);

delay=finddelay(input_signal, h_1_outputs(6,:));
delay=4
MSE_hp4=0;
ideal_val_squared4=0;
%medium frequency signal is 6pi/10=dt frequency, it is on the high side and should be passed
for i = 40:100
    MSE_hp4=MSE_hp4+(cos(6*pi/10*(i-delay-matlab_index_offset))-h_1_outputs(3,i))^2;
    ideal_val_squared4=ideal_val_squared4+(cos(6*pi/10*(i-delay-matlab_index_offset)))^2;
end

snr_hp4 = 10*log(ideal_val_squared4/MSE_hp4);


