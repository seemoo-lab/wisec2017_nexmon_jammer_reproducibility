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