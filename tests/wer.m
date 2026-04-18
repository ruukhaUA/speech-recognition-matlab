function werValue = wer(ref, hyp)
    % Split into word tokens
    r = tokenizeWords(ref);
    h = tokenizeWords(hyp);

    editDist = levenshteinDistance(r, h);

    % WER = edit distance / number of reference words
    werValue = dp(R+1, H+1) / R;
end

