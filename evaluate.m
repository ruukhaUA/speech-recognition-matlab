% evaluate.m
% Automatically sweep audio/ and transcripts/ folders
% and compute WER for each matching pair.
%
% 1.Looks for all valid audio files at "audio/".
% 2.For each audio file, looks for its transcripts.
% 3.It's expected that all transcripts are named like
% "<audio_filename_including_extension>_transcript.txt"
%

clear; clc;

audioDir = "audio/";
transcriptDir = "transcripts/";

language = "en";
mode = "word";

% ---------------------------------------------------------
% 1. Find all audio files in audio/
% ---------------------------------------------------------
audioFilesStruct = dir(fullfile(audioDir, "*.*"));
validExt = {".wav", ".mp3", ".flac", ".m4a"};   % extend if needed

audioFiles = {};

for k = 1:numel(audioFilesStruct)
    [~, ~, ext] = fileparts(audioFilesStruct(k).name);
    if ismember(lower(string(ext)), string(validExt))
        audioFiles{end+1} = fullfile(audioDir, audioFilesStruct(k).name);
    end
end

numFiles = numel(audioFiles);
werValues = zeros(numFiles,1);

% ---------------------------------------------------------
% 2. Loop over all audio files
% ---------------------------------------------------------
for i = 1:numFiles
    audioPath = audioFiles{i};
    [~, base, ext] = fileparts(audioPath);

    % Build expected transcript filename
    transcriptPath = fullfile(transcriptDir, base + ext + "_transcript.txt");

    fprintf("\n==============================\n");
    fprintf("File %d/%d: %s\n", i, numFiles, audioPath);
    fprintf("==============================\n");

    % Check transcript exists
    if ~isfile(transcriptPath)
        fprintf("❌ Transcript not found: %s\n", transcriptPath);
        werValues(i) = NaN;
        continue
    end

    % Load expected transcript
    expected = strtrim(fileread(transcriptPath));

    % Run transcription
    predicted = transcribirAudio(audioPath, language);

    % Compute WER
    w = wer(expected, predicted, mode);
    werValues(i) = w;

    fprintf("Expected:   %s\n", expected);
    fprintf("Predicted:  %s\n", predicted);
    fprintf("WER: %.3f\n", w);
end

% ---------------------------------------------------------
% 3. Global statistics
% ---------------------------------------------------------
validWER = werValues(~isnan(werValues));
meanWER = mean(validWER);

fprintf("\n=====================================\n");
fprintf("   Evaluation complete\n");
fprintf("   Average WER across all files: %.3f\n", meanWER);
fprintf("=====================================\n");