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
