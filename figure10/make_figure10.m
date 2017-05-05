function make_figure10()
    load('../data/correct_frame_67_end_minus_4.mat');

    exp_filenames6 = { ...
        '../data/experiment9.000/S/capture.pcap', ...
        '../data/experiment9.001/S/capture.pcap', ...
        '../data/experiment9.002/S/capture.pcap', ...
        '../data/experiment9.003/S/capture.pcap', ...
        '../data/experiment9.004/S/capture.pcap', ...
        '../data/experiment9.005/S/capture.pcap', ...
        '../data/experiment9.006/S/capture.pcap', ...
        '../data/experiment9.007/S/capture.pcap', ...
        '../data/experiment9.008/S/capture.pcap', ...
    };

    exp_filenames7 = { ...
        '../data/experiment10.000/S/capture.pcap', ...
        '../data/experiment10.001/S/capture.pcap', ...
        '../data/experiment10.002/S/capture.pcap', ...
        '../data/experiment10.003/S/capture.pcap', ...
        '../data/experiment10.004/S/capture.pcap', ...
        '../data/experiment10.005/S/capture.pcap', ...
        '../data/experiment10.006/S/capture.pcap', ...
        '../data/experiment10.007/S/capture.pcap', ...
        '../data/experiment10.008/S/capture.pcap', ...
    };

    exp_filenames8 = { ...
        '../data/experiment11.000/S/capture.pcap', ...
        '../data/experiment11.001/S/capture.pcap', ...
        '../data/experiment11.002/S/capture.pcap', ...
        '../data/experiment11.003/S/capture.pcap', ...
        '../data/experiment11.004/S/capture.pcap', ...
        '../data/experiment11.005/S/capture.pcap', ...
        '../data/experiment11.006/S/capture.pcap', ...
        '../data/experiment11.007/S/capture.pcap', ...
        '../data/experiment11.008/S/capture.pcap', ...
    };

    rate_desc = { ...
        '20in80 MHz', ...          % 1
        '40in80 MHz', ...          % 2
        '80in80 MHz', ...         % 3
    };
    num_rates = length(rate_desc);

    used_rates = [1 2 3];

    exp_filenames = exp_filenames6;
    num_exp = length(exp_filenames);
    num_tx_per_exp = 3000;
    num_tx_total = 26000;

    length_not_ok = zeros(1,1,num_exp, num_tx_total);
    length_ok = zeros(num_rates,1,num_exp, num_tx_total);
    header_not_ok = zeros(num_rates,1,num_exp, num_tx_total);
    header_ok = zeros(num_rates,1,num_exp, num_tx_total);
    fcs_not_ok = zeros(num_rates,1,num_exp, num_tx_total);
    fcs_ok = zeros(num_rates,1,num_exp, num_tx_total);

    %%
    for rate_index = 1:3
        fprintf('Analyzing bandwidth %d out of %d bandwidths\n', rate_index, 3);

        switch (rate_index)
            case 1
                exp_filenames = exp_filenames6;
            case 2
                exp_filenames = exp_filenames7;
            case 3
                exp_filenames = exp_filenames8;
        end

        for iexp = 1:num_exp
            p = readpcap();
            p.open(exp_filenames{iexp});
            f = p.next();
            iframe = 0;
            while(~isempty(f))
                iframe = iframe + 1;
                if ((f.header.orig_len == 1580))
                    radiotap_flags = dec2hex(typecast(f.payload(5:8), 'uint32'));

                    length_ok(rate_index,1,iexp,iframe) = 1;

                    if (isequal(f.payload(67:102), correct_frame(1:36)))
                        header_ok(rate_index,1,iexp,iframe) = 1;
                        % frame has correct length and correct udp header
                        if (isequal(f.payload(67:end-4), correct_frame))
                            fcs_ok(rate_index,1,iexp,iframe) = 1;
                        else
                            fcs_not_ok(rate_index,1,iexp,iframe) = 1;
                        end
                    else
                        header_not_ok(rate_index,1,iexp,iframe) = 1;
                    end
                else
                    length_not_ok(1,1,iexp,iframe) = 1;
                end
                f = p.next();
            end
        end
    end
    %%
    results = cat(2, header_not_ok, fcs_not_ok, fcs_ok);

    %%
    % bitmap of which frames contain valid information for which experiment
    % dim 1: rate
    % dim 2: exp
    % dim 3: frame
    bm = squeeze(sum(cat(2,(header_ok(used_rates,1,:,:)),(header_not_ok(used_rates,1,:,:))),2));

    % we extract the frames actually belonging to one experiment
    % dim 1: rate
    % dim 2: exp
    % dim 3: frame
    header_ok_extract = zeros(length(used_rates), num_exp, 3100);
    header_not_ok_extract = zeros(length(used_rates), num_exp, 3100);
    fcs_ok_extract = zeros(length(used_rates), num_exp, 3100);
    fcs_not_ok_extract = zeros(length(used_rates), num_exp, 3100);
    for iexp = 1:num_exp
        for irate = 1:length(used_rates)
            header_ok_extract(irate,iexp,1:sum(bm(irate,iexp,:))) = header_ok(used_rates(irate),1,iexp,logical(bm(irate,iexp,:)));
            header_not_ok_extract(irate,iexp,1:sum(bm(irate,iexp,:))) = header_not_ok(used_rates(irate),1,iexp,logical(bm(irate,iexp,:)));
            fcs_ok_extract(irate,iexp,1:sum(bm(irate,iexp,:))) = fcs_ok(used_rates(irate),1,iexp,logical(bm(irate,iexp,:)));
            fcs_not_ok_extract(irate,iexp,1:sum(bm(irate,iexp,:))) = fcs_not_ok(used_rates(irate),1,iexp,logical(bm(irate,iexp,:)));
        end
    end

    % we split the frames in intervals of 100
    % dim 1: rate
    % dim 2: exp
    % dim 3: frame in interval
    % dim 4: interval
    intv = 100;
    header_ok_split = reshape(header_ok_extract,length(used_rates), num_exp, intv, []);
    header_not_ok_split = reshape(header_not_ok_extract,length(used_rates), num_exp, intv, []);
    fcs_ok_split = reshape(fcs_ok_extract,length(used_rates), num_exp, intv, []);
    fcs_not_ok_split = reshape(fcs_not_ok_extract,length(used_rates), num_exp, intv, []);

    % we sum up the frames per interval and calculate the median over the
    % intervals. we only select intervals 1:28 to account for some missing
    % frames in the experiments, so that we do the calculations with 2800
    % frames
    % dim 1: rate
    % dim 2: exp
    header_ok_median = median(sum(header_ok_split(:,:,:,1:28),3),4);
    header_not_ok_median = median(sum(header_not_ok_split(:,:,:,1:28),3),4);
    fcs_ok_median = median(sum(fcs_ok_split(:,:,:,1:28),3),4);
    fcs_not_ok_median = median(sum(fcs_not_ok_split(:,:,:,1:28),3),4);

    results_median = cat(3, header_not_ok_median, fcs_not_ok_median, fcs_ok_median);

    %%
    figure(10)
    selected_rates = [1 2 3];
    h = bar(reshape(cat(1,permute(squeeze(results_median(selected_rates,:,2:3)),[2 1 3]),zeros(1,length(selected_rates),2)),[],2),2,'stacked','LineWidth',0.001);
    xlim([0 30])
    %set(gca,'XTick',5:10:25)
    %set(gca,'XTickLabel',rate_desc(used_rates(selected_rates)))
    set(gca,'XTick',[1 3 5 7 9 12 14 16 18 21 23 25 27 29])
    set(gca,'XTickLabel',{'off','60','80','100','120','50','70','90','110','off','60','80','100','120'})
    set(gca,'YTick',0:20:100)
    set(gca,'YTickLabel',{'0%', '20%', '40%', '60%', '80%', '100%'})
    grid on

    legend('FCS incorrect', 'FCS correct');

    matlab2tikz('output/experiment_9_11.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','xtick align=outside,clip mode=individual,legend columns=3,legend style={at={(.5,1.05)},anchor=south,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    h(1).BarWidth = .5;
end
