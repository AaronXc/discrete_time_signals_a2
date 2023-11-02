function ccde = ccde(input_signal, output_signal, numerator_d, denominator_d)

matlab_index_offset=1;

for j = 0:(length(input_signal)-1)
        
        for i=0:(length(numerator_d)-1)
            if j-i >= 0
                output_signal(j+matlab_index_offset)=output_signal(j+matlab_index_offset)+numerator_d(matlab_index_offset+i)*input_signal(j+matlab_index_offset-i);
            else
                output_signal(j+matlab_index_offset)=output_signal(j+matlab_index_offset)+0;
            end
        end
        %start index from 1 because index zero is on the left side of
        %equality sign (its already there)
        for i=1:(length(denominator_d)-1)
            if j-i >= 0
                output_signal(j+matlab_index_offset)=output_signal(j+matlab_index_offset)-denominator_d(i+matlab_index_offset)*output_signal(j+matlab_index_offset-i);
            else
                output_signal(j+matlab_index_offset)=output_signal(j+matlab_index_offset)+0;
            end
        end

end

ccde=output_signal;