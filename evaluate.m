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

    addpath("utils"); savepath; % necesario para que encuentre las funciones auxiliares en `utils/`
    clc;

    if nargin < 1 % comprueba si se ha pasado MAXAUDIOS
        maxAudios = 10000;
    end

    audioDir = "audio/";
    transcriptDir = "transcripts/";
    language = "en";

    audioFiles = findAudioFiles("audio/");

    % Aplicamos límite máximo audios
    numFiles = min(numel(audioFiles), maxAudios);

    % Preasignamos memoria para guardar resultados WER
    werValuesChar = nan(numFiles,1);
    werValuesWord = nan(numFiles,1);


    for i = 1:numFiles
        audioPath = audioFiles{i};
        [~, base, ext] = fileparts(audioPath);

        % Creamos path esperado transcripción
        transcriptPath = fullfile(transcriptDir, base + ext + "_transcript.txt");

        fprintf("\n==============================\n");
        fprintf("File %d/%d: %s\n", i, numFiles, audioPath);
        fprintf("==============================\n");

        % Comprobamos si existe el fichero de transcripción
        if ~isfile(transcriptPath)
            fprintf("❌ Transcript not found: %s\n", transcriptPath);
            werValues(i) = NaN;
            continue
        end

        % Cargamos el fichero de transcripción
        expected = strtrim(fileread(transcriptPath));

        % Obtenemos la transcripción del modelo
        predicted = transcribirAudio(audioPath, language);

        % Obtenemos el WER para ambas granularidades
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
    % Calculamos estadísticas globales
    % ---------------------------------------------------------

    % Filtramos sólo los valores de aquellos ficheros de audio que tenían transcripción válida
    validWERChar = werValuesChar(~isnan(werValuesChar));
    validWERWord = werValuesWord(~isnan(werValuesWord));
    
    meanWERChar = mean(validWERChar);
    meanWERWord = mean(validWERWord);

    fprintf("\n=====================================\n");
    fprintf("   Evaluation complete\n");
    fprintf("   Average WER across all files (char): %.3f\n", meanWERChar);
    fprintf("   Average WER across all files (word): %.3f\n", meanWERWord);
    fprintf("=====================================\n");