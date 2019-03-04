function [] = coefs_ml(csv_path)

    KEY_103_1 =  ["k=0d95748f728eb658718bcd5882154aee";
                  "k=7b54a41dc25a59b59c30d5392af26013";
                  "k=e65525f3aa55ab945748986263e81440";
                  "k=a15486af7c72e993b3ee1411636fbc2a";
                  "k=2ba9c55d741831f6ce5c3e169b87931e";
                  "k=3b8f48986b4bb9afc4bfe81b66282193";
                  "k=ef845d5de98575b1dc262302eb651b88";
                  "k=23893e81d396acc50f6d6ff383f44239";
                  "k=2e0b4482a484200469c8f04a9e1f9b5e";
                  "k=21c66842f6e96c9a670c9c61abd388f0";
                  "k=6a51a0d2d8542f68960fa728ab5133a3";
                  "k=6eef0b6c137a3be4ba3bf0507efb2a98";
                  "k=a1f1651d39af017666ca593e82430e88";
                  "k=8cee8619456f9fb47d84a5c33b8b5ebe";
                  "k=e06f75d885c12073401a449f56c16aa6";
                  "k=4ed3aa62363f77061bfedf72429b023d"];

%     KEY_124_1 = ["k=be5466cf34e90c6cc0ac29b7c97c50dd";
%                    "k=3f84d5b5b54709179216d5d98979fb1b";
%                    "k=b8e1afed6a267e96ba7c9045f12c7f99"]
    FS = filesep;
    if csv_path(end) ~= FS, csv_path = strcat(csv_path,FS); end

    coefs = csvread("c:/Users/MaXusha/kirthi/sca/ml_experiments/models.csv",...
              1, 102, [1, 102, 3254, 102]); % gets the coefs of the STR_BIT
    
    traces_path = strcat('..', filesep, '..', filesep, 'data', filesep, 'ml');
    traces_per_key = 20000; % this is the number of traces per key in DPAv2
    traces_names = strings(traces_per_key * length(KEY_103_1),1);
    fprintf("Saving names of traces with 124-bit set to 1\n");
    for i = 1 : length(KEY_103_1)
        group_id = strcat(traces_path, filesep, "*", KEY_103_1(i), "*");
        structs = dir(group_id);
        for j = 1 : traces_per_key
            cur_tr_index = (i-1)*traces_per_key + j;
            traces_names(cur_tr_index) = structs(j).name;
            fprintf("%s\n",traces_names(cur_tr_index));
        end
    end
    traces_n = 20000 * length(KEY_103_1); % each key is used to encrypt 20k PT
    traces = ones(traces_n, 3254);
%     perm = randperm(length(traces_names), traces_n);
    
    fprintf("Loading %i random traces\n", traces_n);
    for i = 1 : traces_n
%         traces(i, :) = csvread(strcat(csv_path, traces_names(perm(i))));
        traces(i, 1 : end-1) = csvread(strcat(csv_path, traces_names(i)));
        fprintf("%s\n", traces_names(i));
%         fprintf("%s\n", traces_names(perm(i)));
        traces(i, 1 : end-1) = traces(i, 1 : end-1) / max(traces(i,1 : end-1)); 
                       % normalizing everything but the last number needed
                       % for the accuracies
    end
    fprintf("Coefficients loaded\n");
    
    avg = mean(traces, 1);
    
    prods = avg(1:end-1)' .* coefs(1:end-1); % plain prods, no accuracies
    sums = sum(prods);
    fprintf("\n********************\n***SUMS: %f***\n********************\n\n", sums);
    
    prods_and_accuracies = avg' .* coefs;
    sums_and_accuracies = sum(prods_and_accuracies);
    sigmoid = 1/(1 + exp(-sums_and_accuracies));
    fprintf("\n***********************\n***SIGMOID: %f***\n***********************\n", sigmoid);
    
    
    BIT_STR = "bit 103"; % Modify it according to the used bit
    labels = strings(3,1);
    figure;
    plot(coefs(1:end-1)); hold on; labels(1) = strcat("Coefs of ", BIT_STR);
    plot(avg(1:end-1)); hold on; labels(2) = sprintf('Avg of %i with %s = 1', ...
                                                    traces_n, BIT_STR);
    plot(prods_and_accuracies(1:end-1), 'LineWidth', 1); hold on; labels(3) = ...
                                                        'Prods with accuracies';
    legend(labels);

end
