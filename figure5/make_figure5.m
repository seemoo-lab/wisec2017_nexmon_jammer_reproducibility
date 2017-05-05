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

function make_figure5()
    if ~exist('experiment_2','var')
        load('../data/experiment_2.mat');
    end

    % sampling frequency
    Fs = 5000; % Hz

    % the length of one experiment is 15 seconds (10 seconds signal
    % transmission, 5 seconds break). The whole length has to be adjusted.
    explen = 70*Fs+2191;

    % number of experiments
    expnum = 16;

    % split the capture into separate experiments
    experiment_2_split = reshape(experiment_2(85001:(85000+explen*expnum)),explen,[]);
    %%
    % plot(experiment_1_split)
    experiment_2_cut = reshape(experiment_2_split(50001:250000,:),1000,[],expnum);
    %%
    figure(5)
    h = barh(median(squeeze(mean(experiment_2_cut(:,:,10:16),1))),4,'FaceColor',[0.97630,0.98310,0.05380]);
    hold on
    boxplot(squeeze(mean(experiment_2_cut(:,:,10:16),1)), 'orientation', 'horizontal');
    hold off
    set(gca, 'YTickLabel', {'MPC','CH7 20MHz','CH7 40MHz','CH7 80MHz','CH106 20MHz','CH106 40MHz','CH106 80MHz'})
    xlabel('Power [mW]');
    grid on
    %xticks(1:10:226)
    disp(['median: ' num2str(median(squeeze(mean(experiment_2_cut(:,:,10:16),1))))]);

    matlab2tikz('output/experiment_2.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    h.BarWidth = .5;
end
