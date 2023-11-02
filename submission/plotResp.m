%frequency response plotting

%signals are the 2 dimensional vectors to plot

% n is the number of signals for plotting
% 
% %fign is number of the figure within the script to plot

% subP1 number of total subplots 

% subP2 number of rows of subplots

% signals is the array of dependent axis signals to plot

% indep_ax is the array of independent axis signals to plot

% len is the array of independent axis lengths

% titles is the array of titles for the subplots

% ylabels is the array of ylabels for the subplots

% xlabels is the arrary of xlabels for the subplots

function plotResp = plotResp(n,fign,subP1,subP2,signals,indep_ax,len,titles,ylabels,xlabels, stemP)
    figure(fign)
%checks
    [M,N]=size(signals);
    if length(len)==n %fails silently if badly formatted data is passed
        if n == M %fails silently if badly formatted data is passed
            for i = 1:n
                subplot(subP1, subP2, i)
                if(stemP)
                    stem(indep_ax(i:i,1:len(i)),signals(i:i,1:len(i)));
                else
                    plot(indep_ax(i:i,1:len(i)),signals(i:i,1:len(i)));
                end
           
                title((titles(i)))
                ylabel(ylabels(i))
                xlabel(xlabels(i))                
            end
        end
    end