%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%          ###########   ###########   ##########    ##########           %
%         ############  ############  ############  ############          %
%         ##            ##            ##   ##   ##  ##        ##          %
%         ##            ##            ##   ##   ##  ##        ##          %
%         ###########   ####  ######  ##   ##   ##  ##    ######          %
%          ###########  ####  #       ##   ##   ##  ##    #    #          %
%                   ##  ##    ######  ##   ##   ##  ##    #    #          %
%                   ##  ##    #       ##   ##   ##  ##    #    #          %
%         ############  ##### ######  ##   ##   ##  ##### ######          %
%         ###########    ###########  ##   ##   ##   ##########           %
%                                                                         %
%            S E C U R E   M O B I L E   N E T W O R K I N G              %
%                                                                         %
% License:                                                                %
%                                                                         %
% Copyright (c) 2017 Secure Mobile Networking Lab (SEEMOO)                %
%                                                                         %
% Permission is hereby granted, free of charge, to any person obtaining a %
% copy of this software and associated documentation files (the           %
% "Software"), to deal in the Software without restriction, including     %
% without limitation the rights to use, copy, modify, merge, publish,     %
% distribute, sublicense, and/or sell copies of the Software, and to      %
% permit persons to whom the Software is furnished to do so, subject to   %
% the following conditions:                                               %
%                                                                         %
% 1. The above copyright notice and this permission notice shall be       %
%    include in all copies or substantial portions of the Software.       %
%                                                                         %
% 2. Any use of the Software which results in an academic publication or  %
%    other publication which includes a bibliography must include         %
%    citations to the nexmon project a) and the paper cited under b):     %
%                                                                         %
%    a) "Matthias Schulz, Daniel Wegemer and Matthias Hollick. Nexmon:    %
%        The C-based Firmware Patching Framework. https://nexmon.org      %
%                                                                         %
%    b) "Matthias Schulz, Francesco Gringoli, Daniel Steinmetzer, Michael %
%        Koch, Matthias Hollick. Massive Reactive Smartphone-Based        %
%        Jamming using Arbitrary Waveforms and Adaptive Power Control.    %
%        Proceedings of the 10th ACM Conference on Security and Privacy   %
%        in Wireless and Mobile Networks (WiSec 2017), July 2017.         %
%                                                                         %
% 3. The Software is not used by, in cooperation with, or on behalf of    %
%    any armed forces, intelligence agencies, reconnaissance agencies,    %
%    defense agencies, offense agencies or any supplier, contractor, or   %
%    research associated.                                                 %
%                                                                         %
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS %
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF              %
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  %
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY    %
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,    %
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE       %
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                  %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function make_figure14()
    exp_filenames = { ...
        '../data/experiment12.011/J/exp12.011.csv', ...
        '../data/experiment12.012/J/exp12.012.csv', ...
        '../data/experiment12.013/J/exp12.013.csv', ...
    };

    fs = 5000;

    exp12011 = csvread(exp_filenames{1},2,1);
    exp12012 = csvread(exp_filenames{2},2,1);
    exp12013 = csvread(exp_filenames{3},2,1);
    
    int = 20*fs:50*fs-1;

    %%
    average_power = [ ...
        median(mean(reshape(exp12013(int),1000,[]),2)); ...
        median(mean(reshape(exp12012(int),1000,[]),2)); ...
        median(mean(reshape(exp12011(int),1000,[]),2)); ...
    ];

    figure(14)
    h = barh(average_power,4,'FaceColor',[0.97630,0.98310,0.05380]);
    hold on
    boxplot([ ...
        mean(reshape(exp12013(int),1000,[]),2) ...
        mean(reshape(exp12012(int),1000,[]),2) ...
        mean(reshape(exp12011(int),1000,[]),2) ...
    ], 'orientation', 'horizontal')
    set(gca,'YTick',[1 2 3])
    set(gca,'YTickLabel',{'Adaptive Power Control J.', 'Acknowledging Jammer','Reactive Jammer'})
    ylim([0.5 3.5])
    xlabel('Total Power Consumption [mW]')
    hold off
    grid on

    matlab2tikz('output/experiment_12c.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,legend columns=2,legend style={at={(.5,1.05)},anchor=south,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    h(1).BarWidth = .5;
end
