function wer = wer(ref, hyp, mode)
    % Split into word tokens
    r = tokenizeWords(ref, mode);
    h = tokenizeWords(hyp, mode);

    editDist = levenshteinDistance(r, h);

    % WER = edit distance / number of reference words
    wer = editDist / numel(r);
end

