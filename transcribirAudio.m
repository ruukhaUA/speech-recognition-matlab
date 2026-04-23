function texto = transcribirAudio(rutaAudio, idioma)
    [audio, fs] = audioread(rutaAudio);

    if size(audio,2) > 1
        audio = mean(audio,2);
    end

    sound(audio, fs);
    pause(length(audio)/fs + 0.5)

    cliente = speechClient("wav2vec2.0");
    % cliente.Language = idioma;

    texto = speech2text(audio, fs, Client=cliente);
    % If wav2vec2.0 returns a table, convert it to a single string
    if istable(texto)
        texto = strjoin(texto.Transcript, " ");
    end



    disp("Transcripción:")
    disp(texto)
end