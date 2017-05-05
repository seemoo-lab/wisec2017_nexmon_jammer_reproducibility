function make_figure2()
    normsig = @(sig) sig./max(max(real(sig)),max(imag(sig)));
    paprdB = @(s) 10*log10(max(abs(s))^2/rms(s));
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
