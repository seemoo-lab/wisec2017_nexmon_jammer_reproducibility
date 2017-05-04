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
