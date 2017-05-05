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

function make_figure13()
    [z,fs,fc,header] = iqtread('../data/testjam24MbsL1400wack.iqt');
    timez = (0:(length(z)/10) - 1) / fs / 1e-6;

    mycolor1 = [0.00000,0.44700,0.74100];
    mycolor2 = [0.85000,0.32500,0.09800];
    mycolor3 = [0.92900,0.69400,0.12500];
    mycolor4 = [0.49400,0.18400,0.55600];

    % downsample factor
    dsf = 16;
    z = decimate(z(1:length(timez)), dsf);
    timez = downsample(timez, dsf);

    figure1 = figure(1); clf; hold on;

    plot(timez / 1e3, abs(z) / max(abs(z)), 'Color', mycolor1);

    grid on;
    xlim([0 2]);

    xl = xlabel('Time (ms)');
    yl = ylabel('Signal amplitude');
    %tl = title('r=24Mb/s, P_{len} = 1400B'); set(tl, 'FontSize', 12);

    % Create rectangle
    annotation(figure1,'rectangle',...
        [0.427604166666667 0.36 0.03 0.56],...
        'Color',mycolor2);

    % Create rectangle
    annotation(figure1,'rectangle',...
        [0.705729166666667 0.36 0.03 0.56],...
        'Color',mycolor2);

    % Create rectangle
    annotation(figure1,'rectangle',...
        [0.880208333333333 0.30 0.0237499999999999 0.33],...
        'Tag','test',...
        'Color',mycolor4);

    % Create rectangle
    annotation(figure1,'rectangle',...
        [0.598958333333333 0.30 0.0237499999999999 0.33],...
        'Tag','test',...
        'Color',mycolor4);

    % Create rectangle
    annotation(figure1,'rectangle',...
        [0.357291666666667 0.30 0.02375 0.33],...
        'Tag','test',...
        'Color',mycolor4);

    % Create rectangle
    annotation(figure1,'rectangle',...
        [0.1859375 0.36 0.03 0.56],...
        'Color',mycolor2);

    text(0.23,0.95,'Jamming','HorizontalAlignment','left','Color',mycolor2);
    text(0.85,0.95,'Jamming','HorizontalAlignment','left','Color',mycolor2);
    text(1.57,0.95,'Jamming','HorizontalAlignment','left','Color',mycolor2);

    text(0.595,0.7,'Ack','HorizontalAlignment','center','Color',mycolor4);
    text(1.225,0.7,'Ack','HorizontalAlignment','center','Color',mycolor4);
    text(1.945,0.7,'Ack','HorizontalAlignment','center','Color',mycolor4);

    matlab2tikz('output/testjam24MbsL1400wack.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);
end
