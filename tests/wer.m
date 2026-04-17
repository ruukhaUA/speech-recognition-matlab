function werValue = wer(ref, hyp)
    % Split into word tokens
    r = strsplit(strtrim(lower(ref)));
    h = strsplit(strtrim(lower(hyp)));

    R = length(r);
    H = length(h);

    % DP matrix
    dp = zeros(R+1, H+1);

    % Initialize first row/column
    for i = 1:R+1
        dp(i,1) = i - 1;
    end
    for j = 1:H+1
        dp(1,j) = j - 1;
    end

    % Fill DP table
    for i = 2:R+1
        for j = 2:H+1
            if strcmp(r{i-1}, h{j-1})
                cost = 0;
            else
                cost = 1;
            end

            dp(i,j) = min([
                dp(i-1,j) + 1,      % deletion
                dp(i,j-1) + 1,      % insertion
                dp(i-1,j-1) + cost  % substitution
            ]);
        end
    end

    % WER = edit distance / number of reference words
    werValue = dp(R+1, H+1) / R;
end

