function make_figure9()
    load('../data/correct_frame_67_end_minus_4.mat');

    exp_filenames = { ...
        '../data/experiment4.000/S/capture.pcap', ...
        '../data/experiment4.001/S/capture.pcap', ...
        '../data/experiment4.002/S/capture.pcap', ...
        '../data/experiment4.003/S/capture.pcap', ...
        '../data/experiment4.004/S/capture.pcap', ...
        '../data/experiment4.005/S/capture.pcap', ...
        '../data/experiment4.006/S/capture.pcap', ...
        '../data/experiment4.007/S/capture.pcap', ...
        '../data/experiment4.008/S/capture.pcap', ...
    };

    rate_desc = { ...
        '1M DSSS', ...          % 1
        '2M DSSS', ...          % 2
        '5M5 DSSS', ...         % 3
        '11M DSSS', ...         % 4
        '6M OFDM', ...          % 5
        '9M OFDM', ...          % 6
        '12M OFDM', ...         % 7
        '18M OFDM', ...         % 8
        '24M OFDM', ...         % 9
        '36M OFDM', ...         % 10
        '48M OFDM', ...         % 11
        '54M OFDM', ...         % 12
        'HT MCS 0', ...         % 13
        'HT MCS 1', ...         % 14
        'HT MCS 2', ...         % 15
        'HT MCS 3', ...         % 16
        'HT MCS 4', ...         % 17
        'HT MCS 5', ...         % 18
        'HT MCS 6', ...         % 19
        'HT MCS 7', ...         % 20
        'HT MCS 0 LDPC', ...    % 21
        'HT MCS 1 LDPC', ...    % 22
        'HT MCS 2 LDPC', ...    % 23
        'HT MCS 3 LDPC', ...    % 24
        'HT MCS 4 LDPC', ...    % 25
        'HT MCS 5 LDPC', ...    % 26
        'HT MCS 6 LDPC', ...    % 27
        'HT MCS 7 LDPC', ...    % 28
    };

    rate_desc_short = { ...
        '1 Mbps', ...          % 1
        '2 Mbps', ...          % 2
        '5.5 Mbps', ...         % 3
        '11 Mbps', ...         % 4
        '6 Mbps', ...          % 5
        '9 Mbps', ...          % 6
        '12 Mbps', ...         % 7
        '18 Mbps', ...         % 8
        '24 Mbps', ...         % 9
        '36 Mbps', ...         % 10
        '48 Mbps', ...         % 11
        '54 Mbps', ...         % 12
        'MCS 0', ...         % 13
        'MCS 1', ...         % 14
        'MCS 2', ...         % 15
        'MCS 3', ...         % 16
        'MCS 4', ...         % 17
        'MCS 5', ...         % 18
        'MCS 6', ...         % 19
        'MCS 7', ...         % 20
        'MCS 0 LDPC', ...    % 21
        'MCS 1 LDPC', ...    % 22
        'MCS 2 LDPC', ...    % 23
        'MCS 3 LDPC', ...    % 24
        'MCS 4 LDPC', ...    % 25
        'MCS 5 LDPC', ...    % 26
        'MCS 6 LDPC', ...    % 27
        'MCS 7 LDPC', ...    % 28
    };

    used_rates = [5 6 7 8 9 10 11 12 13 21 14 22 15 23 16 24 17 25];

    mcs_max = 7;
    num_exp = length(exp_filenames);
    num_tx_per_exp = 3000;
    num_tx_total = num_tx_per_exp * length(used_rates) + 1000;

    length_not_ok = zeros(1,1,num_exp, num_tx_total);
    length_ok = zeros(12+2*(mcs_max + 1),1,num_exp, num_tx_total);
    header_not_ok = zeros(12+2*(mcs_max + 1),1,num_exp, num_tx_total);
    header_ok = zeros(12+2*(mcs_max + 1),1,num_exp, num_tx_total);
    fcs_not_ok = zeros(12+2*(mcs_max + 1),1,num_exp, num_tx_total);
    fcs_ok = zeros(12+2*(mcs_max + 1),1,num_exp, num_tx_total);

    %%
    for iexp = 1:num_exp
        fprintf('analyzing file %d out of %d files\n', iexp, num_exp);
        p = readpcap();
        p.open(exp_filenames{iexp});
        f = p.next();
        iframe = 0;
        while(~isempty(f))
            iframe = iframe + 1;
            if ((f.header.orig_len == 1580))
                radiotap_flags = dec2hex(typecast(f.payload(5:8), 'uint32'));
                data_rate = f.payload(18);
                mcs_info = f.payload(25);
                ldpc = f.payload(26);
                mcs = f.payload(27);
                if (data_rate > 0)
                    switch (data_rate)
                        case 2
                            rate_index = 1;
                        case 4
                            rate_index = 2;
                        case 11
                            rate_index = 3;
                        case 22
                            rate_index = 4;
                        case 12
                            rate_index = 5;
                        case 18
                            rate_index = 6;
                        case 24
                            rate_index = 7;
                        case 36
                            rate_index = 8;
                        case 48
                            rate_index = 9;
                        case 72
                            rate_index = 10;
                        case 96
                            rate_index = 11;
                        case 108
                            rate_index = 12;
                        otherwise
                            disp('wrong rate')
                    end
                    chanspec = data_rate;
                elseif (mcs_info == hex2dec('3f'))
                    if (ldpc == hex2dec('10'))
                        rate_index = 12 + mcs + 1 + mcs_max + 1;
                    else
                        rate_index = 12 + mcs + 1;
                    end
                else
                    disp('wrong rate')
                end

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
    figure(9)
    selected_rates = [1 2 3 4 5 9 10 11 12 13 14 15 16];
    h = bar(reshape(cat(1,permute(squeeze(results_median(selected_rates,:,2:3)),[2 1 3]),zeros(1,length(selected_rates),2)),[],2),2,'stacked','LineWidth',0.001);
    xlim([0 130])
    %set(gca,'XTick',5:10:125)
    %set(gca,'XTickLabel',rate_desc_short(used_rates(selected_rates)))
    set(gca,'XTick',[1 4 7 13 16 19 22 25 28 31 34 37 43 46 49 52 55 58 61    64    67    73    76    79    82    85    88    91    94    97   103   106   109   112   115   118 121   124   127])
    set(gca,'XTickLabel',{'off','70','100','60','90','120','50','80','110','off','70','100','60','90','120','50','80','110','off','70','100','60','90','120','50','80','110','off','70','100','60','90','120','50','80','110','off','70','100'})
    set(gca,'YTick',0:20:100)
    set(gca,'YTickLabel',{'0%', '20%', '40%', '60%', '80%', '100%'})
    grid on

    legend('FCS incorrect', 'FCS correct');

    matlab2tikz('output/experiment_4a.tex',...
        'width','\figurewidth',...
        'height','\figureheight',...
        'extraAxisOptions','xtick align=outside,clip mode=individual,legend columns=3,legend style={at={(.5,1.05)},anchor=south,draw=black,fill=white,legend cell align=left}',...
        'extraTikzpictureOptions','font=\footnotesize',...
        'checkForUpdates',false,'showInfo',false);

    h(1).BarWidth = 0.5;
end
