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

function make_figure2()
    normsig = @(sig) sig./max(max(real(sig)),max(imag(sig)));
    paprdB = @(s) 10*log10(max(abs(s))^2/rms(s)^2);
    powerdB = @(s) 10*log10(rms(s)^2);

    tone1freq = zeros(160,1);
    tone1freq(1:40) = 1;
    tone1freq(160-39:160) = 1;
    tone1time = normsig(ifft(tone1freq));

    tone2freq = zeros(160,1);
    tone2freq(10) = 1;
    tone2time = normsig(ifft(tone2freq));

    figure(21)
    plot(-80:79,fftshift([real(tone1time) imag(tone1time)]));
    xlabel('samples')
    ylabel('amplitude')
    ylim([-1.5 1.1])

    matlab2tikz('output/tonegeneration_tone1time.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    figure(22)
    stem(-80:79,fftshift(abs(tone1freq)),'.','MarkerSize',1)
    ylim([-.1 10])
    yticks([0 1])

    matlab2tikz('output/tonegeneration_tone1freq.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    figure(23)
    plot(-80:79,fftshift([real(tone2time) imag(tone2time)]))
    xlabel('samples')
    ylabel('amplitude')
    ylim([-1.5 1.1])

    matlab2tikz('output/tonegeneration_tone2time.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    figure(24)
    stem(-80:79,fftshift(abs(tone2freq)),'.','MarkerSize',1)
    ylim([-.1 10])
    yticks([0 1])

    matlab2tikz('output/tonegeneration_tone2freq.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    papr1 = paprdB(tone1time);
    papr2 = paprdB(tone2time);

    power1 = powerdB(tone1time);
    power2 = powerdB(tone2time);

    fprintf('papr1: %f dB   papr2: %f dB   power1: %f dBr   power2: %f dBr\n', ...
        papr1, papr2, power1, power2)

    close all;

    figure(2)
    subplot(1,2,1)
    yyaxis left
    h = plot(-80:79,fftshift([real(tone2time) imag(tone2time)]),'-');
    h(1).Color = [0 0.4470 0.7410];
    h(2).Color = [0.8500 0.3250 0.0980];
    xlabel('samples')
    ylabel('amplitude')
    ylim([-1.5 1.1])
    yyaxis right
    h = stem(-80:79,fftshift(abs(tone2freq)),'.','MarkerSize',1);
    h.Color = [0 0.4470 0.7410];
    ylim([-.1 10])
    yticks([0 1])
    xlim([-80 80])
    ax = gca;
    ax.YAxis(1).Color = [0 0 0];
    ax.YAxis(2).Color = [0 0 0];

    subplot(1,2,2)
    yyaxis left
    h = plot(-80:79,fftshift([real(tone1time) imag(tone1time)]),'-');
    h(1).Color = [0 0.4470 0.7410];
    h(2).Color = [0.8500 0.3250 0.0980];
    xlabel('samples')
    ylabel('amplitude')
    ylim([-1.5 1.1])
    yyaxis right
    h = stem(-80:79,fftshift(abs(tone1freq)),'.','MarkerSize',1);
    h.Color = [0 0.4470 0.7410];
    ylim([-.1 10])
    yticks([0 1])
    xlim([-80 80])
    ax = gca;
    ax.YAxis(1).Color = [0 0 0];
    ax.YAxis(2).Color = [0 0 0];
end
