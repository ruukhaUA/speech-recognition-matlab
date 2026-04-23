% evaluate.m
% Batch‑test wav2vec2.0 transcription + WER evaluation

clear; clc;

addpath("tests")

% ---------------------------------------------------------
% 1. Define your dataset
% ---------------------------------------------------------
audioFiles = {
    "audio/ai.wav"
    "audio/dft.mp3"
    "audio/test.wav"
};

transcriptFiles = {
    "transcripts/ai.wav_transcript.txt"
    "transcripts/dft.mp3_transcript.txt"
    "transcripts/test.wav_transcript.txt"
};

language = "en-US";   % or "es-ES", etc.
mode = "word";       % your tokenizer mode

numFiles = numel(audioFiles);
werValues = zeros(numFiles,1);

% ---------------------------------------------------------
% 2. Loop over all files
% ---------------------------------------------------------
for i = 1:numFiles
    fprintf("\n==============================\n");
    fprintf("File %d/%d: %s\n", i, numFiles, audioFiles{i});
    fprintf("==============================\n");

    % --- Load expected transcript ---
    expected = strtrim(fileread(transcriptFiles{i}));

    % --- Run your transcription function ---
    predicted = transcribirAudio(audioFiles{i}, language);

    % --- Compute WER ---
    w = wer(expected, predicted, mode);
    werValues(i) = w;

    fprintf("Expected:   %s\n", expected);
    fprintf("Predicted:  %s\n", predicted);
    fprintf("WER: %.3f\n", w);
end

% ---------------------------------------------------------
% 3. Global statistics
% ---------------------------------------------------------
meanWER = mean(werValues);

fprintf("\n=====================================\n");
fprintf("   Evaluation complete\n");
fprintf("   Average WER across all files: %.3f\n", meanWER);
fprintf("=====================================\n");

