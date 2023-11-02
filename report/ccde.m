function ccde = ccde(input\textunderscore signal, output\textunderscore signal, numerator\textunderscore d, denominator\textunderscore d)

matlabIndexOffset=1;

for j = 0:(length(input\textunderscore signal)-1)
        
        for i=0:(length(numerator\textunderscore d)-1)
            if j-i >= 0
                output\textunderscore signal(j+matlabIndexOffset)=output\textunderscore signal(j+matlabIndexOffset)+numerator\textunderscore d(matlabIndexOffset+i)*input\textunderscore signal(j+matlabIndexOffset-i);
            else
                output\textunderscore signal(j+matlabIndexOffset)=output\textunderscore signal(j+matlabIndexOffset)+0;
            end
        end
        %start index from 1 because index zero is on the left side of
        %equality sign (its already there)
        for i=1:(length(denominator\textunderscore d)-1)
            if j-i >= 0
                output\textunderscore signal(j+matlabIndexOffset)=output\textunderscore signal(j+matlabIndexOffset)-denominator\textunderscore d(i+matlabIndexOffset)*output\textunderscore signal(j+matlabIndexOffset-i);
            else
                output\textunderscore signal(j+matlabIndexOffset)=output\textunderscore signal(j+matlabIndexOffset)+0;
            end
        end

end

ccde=output\textunderscore signal;