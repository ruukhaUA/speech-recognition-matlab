function evaluate(maxAudios)
% EVALUATE  Evalúa la precisión del modelo de transcripción sobre un conjunto de audios.
%
%   EVALUATE(MAXAUDIOS) procesa hasta MAXAUDIOS ficheros de audio ubicados en la
%   carpeta `audio/`. Para cada audio, busca su transcripción de referencia en
%   `transcripts/`, siguiendo la nomenclatura:
%
%       "<nombre_del_audio><extensión>_transcript.txt"
%
%   Por cada par audio–transcripción:
%       • Ejecuta la función TRANSCIBIRAUDIO para obtener la predicción del modelo.
%       • Calcula el WER (Word Error Rate) a nivel palabra y a nivel carácter,
%         usando la función WER proporcionada por el usuario.
%       • Muestra por pantalla el resultado individual.
%
%   Al finalizar, informa del WER medio (palabra y carácter) considerando solo los
%   ficheros con transcripción válida.
%
%   Si MAXAUDIOS no se especifica, se procesan como máximo 10 000 audios.
%
%   La función asume la siguiente estructura de directorios:
%       audio/        — ficheros de audio (.wav, .mp3, .flac, .m4a)
%       transcripts/  — transcripciones de referencia en texto plano
%
%   Ejemplo:
%       evaluate(100)
%

    addpath("utils"); savepath;
    clc;

    if nargin < 1
        maxAudios = 10000
    end

    %if nargin < 1
    %error("You must specify mode: 'word' or 'char'")
    %end

    audioDir = "audio/";
    transcriptDir = "transcripts/";

    language = "en";

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

    % Apply maxAudios limit
    numFiles = min(numel(audioFiles), maxAudios);
    werValuesChar = nan(numFiles,1);
    werValuesWord = nan(numFiles,1);

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
        wChar = wer(expected, predicted, "char");
        wWord = wer(expected, predicted, "word");
        werValuesChar(i) = wChar;
        werValuesWord(i) = wWord;

        fprintf("Expected:   %s\n", expected);
        fprintf("Predicted:  %s\n", predicted);
        fprintf("WER (char): %.3f\n", wChar);
        fprintf("WER (word): %.3f\n", wWord);
    end

    % ---------------------------------------------------------
    % 3. Global statistics
    % ---------------------------------------------------------
    validWERChar = werValuesChar(~isnan(werValuesChar));
    meanWERChar = mean(validWERChar);
    validWERWord = werValuesWord(~isnan(werValuesWord));
    meanWERWord = mean(validWERWord);

    fprintf("\n=====================================\n");
    fprintf("   Evaluation complete\n");
    fprintf("   Average WER across all files (char): %.3f\n", meanWERChar);
    fprintf("   Average WER across all files (word): %.3f\n", meanWERWord);
    fprintf("=====================================\n");