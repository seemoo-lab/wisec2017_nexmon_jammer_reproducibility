function make_figure6()
    if ~exist('experiment_1_CH7_20MHz','var')
        load('../data/experiment_1_CH7_20MHz.mat');
    end

    if ~exist('experiment_1_CH7_40MHz','var')
        load('../data/experiment_1_CH7_40MHz.mat');
    end

    if ~exist('experiment_1_CH7_80MHz','var')
        load('../data/experiment_1_CH7_80MHz.mat');
    end

    if ~exist('experiment_1_CH106_20MHz','var')
        load('../data/experiment_1_CH106_20MHz.mat');
    end

    if ~exist('experiment_1_CH106_40MHz','var')
        load('../data/experiment_1_CH106_40MHz.mat');
    end

    if ~exist('experiment_1_CH106_80MHz','var')
        load('../data/experiment_1_CH106_80MHz.mat');
    end

    % sampling frequency
    Fs = 5000; % Hz

    % number of experiments
    expnum = 128-25;

    expstart_CH7_20MHz = 85000;
    expstart_CH7_40MHz = 85000;
    expstart_CH7_80MHz = 90000;
    expstart_CH106_20MHz = 85000;
    expstart_CH106_40MHz = 85000;
    expstart_CH106_80MHz = 90000;

    % the length of one experiment is 70 seconds (60 seconds signal
    % transmission, 10 seconds break). The whole length has to be adjusted.
    explen_CH7_20MHz = 70*Fs+2191;
    explen_CH7_40MHz = 70*Fs+2191;
    explen_CH7_80MHz = 70*Fs+2191;
    explen_CH106_20MHz = 70*Fs+2191;
    explen_CH106_40MHz = 70*Fs+2191;
    explen_CH106_80MHz = 70*Fs+2191;

    % split the capture into separate experiments
    experiment_1_split_CH7_20MHz = reshape(experiment_1_CH7_20MHz(expstart_CH7_20MHz + (1:(explen_CH7_20MHz*expnum))),explen_CH7_20MHz,[]);
    experiment_1_split_CH7_40MHz = reshape(experiment_1_CH7_40MHz(expstart_CH7_40MHz + (1:(explen_CH7_40MHz*expnum))),explen_CH7_40MHz,[]);
    experiment_1_split_CH7_80MHz = reshape(experiment_1_CH7_80MHz(expstart_CH7_80MHz + (1:(explen_CH7_80MHz*expnum))),explen_CH7_80MHz,[]);
    experiment_1_split_CH106_20MHz = reshape(experiment_1_CH106_20MHz(expstart_CH106_20MHz + (1:(explen_CH106_20MHz*expnum))),explen_CH106_20MHz,[]);
    experiment_1_split_CH106_40MHz = reshape(experiment_1_CH106_40MHz(expstart_CH106_40MHz + (1:(explen_CH106_40MHz*expnum))),explen_CH106_40MHz,[]);
    experiment_1_split_CH106_80MHz = reshape(experiment_1_CH106_80MHz(expstart_CH106_80MHz + (1:(explen_CH106_80MHz*expnum))),explen_CH106_80MHz,[]);

    % plot(experiment_1_split)
    experiment_1_cut_CH7_20MHz = reshape(experiment_1_split_CH7_20MHz(50001:250000,:),1000,[],expnum);
    experiment_1_cut_CH7_40MHz = reshape(experiment_1_split_CH7_40MHz(50001:250000,:),1000,[],expnum);
    experiment_1_cut_CH7_80MHz = reshape(experiment_1_split_CH7_80MHz(50001:250000,:),1000,[],expnum);
    experiment_1_cut_CH106_20MHz = reshape(experiment_1_split_CH106_20MHz(50001:250000,:),1000,[],expnum);
    experiment_1_cut_CH106_40MHz = reshape(experiment_1_split_CH106_40MHz(50001:250000,:),1000,[],expnum);
    experiment_1_cut_CH106_80MHz = reshape(experiment_1_split_CH106_80MHz(50001:250000,:),1000,[],expnum);

    experiment_1_cut_idle_CH7_20MHz = reshape(experiment_1_split_CH7_20MHz(310001:350000,:),1000,[],expnum);
    experiment_1_cut_idle_CH7_40MHz = reshape(experiment_1_split_CH7_40MHz(310001:350000,:),1000,[],expnum);
    experiment_1_cut_idle_CH7_80MHz = reshape(experiment_1_split_CH7_80MHz(310001:350000,:),1000,[],expnum);
    experiment_1_cut_idle_CH106_20MHz = reshape(experiment_1_split_CH106_20MHz(310001:350000,:),1000,[],expnum);
    experiment_1_cut_idle_CH106_40MHz = reshape(experiment_1_split_CH106_40MHz(310001:350000,:),1000,[],expnum);
    experiment_1_cut_idle_CH106_80MHz = reshape(experiment_1_split_CH106_80MHz(310001:350000,:),1000,[],expnum);

    %%
    experiment_1_median = [ ...
        median(squeeze(mean(experiment_1_cut_CH7_20MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_CH7_40MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_CH7_80MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_CH106_20MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_CH106_40MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_CH106_80MHz,1))); ...
    ].';

    experiment_1_idle_median = [ ...
        median(squeeze(mean(experiment_1_cut_idle_CH7_20MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_idle_CH7_40MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_idle_CH7_80MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_idle_CH106_20MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_idle_CH106_40MHz,1))); ...
        median(squeeze(mean(experiment_1_cut_idle_CH106_80MHz,1))); ...
    ].';

    %%
    plot(25:127, experiment_1_median - experiment_1_idle_median);
    legend('CH7 20MHz', 'CH7 40MHz', 'CH7 80MHz', 'CH106 20MHz', 'CH106 40MHz', 'CH106 80MHz');
    xlim([25 127])
    xlabel('Power Index');
    ylabel('Power [mW]');
    grid on
    yticks(500:100:1000);

    matlab2tikz('output/experiment_1.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','clip mode=individual,transpose legend,legend columns=3,legend style={at={(1,1)},anchor=north east,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);
end
