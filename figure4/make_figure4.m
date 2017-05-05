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

function make_figure4()
    tssi_g700_CH7_20MHz_EXP0;
    tssi = zeros([size(tssi_7_20) 6 3]);
    tssi(:,:,1,1) = tssi_7_20;

    tssi_g700_CH7_20MHz_EXP1;
    tssi(:,:,1,2) = tssi_7_20;

    tssi_g700_CH7_20MHz_EXP2;
    tssi(:,:,1,3) = tssi_7_20;

    tssi_g701_CH7_40MHz_L_EXP0
    tssi(:,:,2,1) = tssi_7_40L;

    tssi_g701_CH7_40MHz_L_EXP1
    tssi(:,:,2,2) = tssi_7_40L;

    tssi_g701_CH7_40MHz_L_EXP2
    tssi(:,:,2,3) = tssi_7_40L;

    tssi_g702_CH7_80MHz_L_EXP0
    tssi(:,:,3,1) = tssi_7_80L;

    tssi_g702_CH7_80MHz_L_EXP1
    tssi(:,:,3,2) = tssi_7_80L;

    tssi_g702_CH7_80MHz_L_EXP2
    tssi(:,:,3,3) = tssi_7_80L;


    tssi_g703_CH106_20MHz_EXP0;
    tssi(:,:,4,1) = tssi_106_20;

    tssi_g703_CH106_20MHz_EXP1;
    tssi(:,:,4,2) = tssi_106_20;

    tssi_g703_CH106_20MHz_EXP2;
    tssi(:,:,4,3) = tssi_106_20;

    tssi_g704_CH106_40MHz_L_EXP0
    tssi(:,:,5,1) = tssi_106_40L;

    tssi_g704_CH106_40MHz_L_EXP1
    tssi(:,:,5,2) = tssi_106_40L;

    tssi_g704_CH106_40MHz_L_EXP2
    tssi(:,:,5,3) = tssi_106_40L;

    tssi_g705_CH106_80MHz_L_EXP0
    tssi(:,:,6,1) = tssi_106_80L;

    tssi_g705_CH106_80MHz_L_EXP1
    tssi(:,:,6,2) = tssi_106_80L;

    tssi_g705_CH106_80MHz_L_EXP2
    tssi(:,:,6,3) = tssi_106_80L;

    figure(4)
    plot(0:127, squeeze(mean(tssi(2:end,1,:,:),4)));
    legend('CH7 20MHz', 'CH7 40MHz', 'CH7 80MHz', 'CH106 20MHz', 'CH106 40MHz', 'CH106 80MHz');
    xlabel('Power Index');
    ylabel('TSSI');
    xlim([0 127])
    ylim([0 1100])
    yticks(0:200:1000)
    grid on
    matlab2tikz('output/tssi.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);
end