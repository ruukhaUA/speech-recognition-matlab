function texto = transcribirAudio(rutaAudio, idioma)
    [audio, fs] = audioread(rutaAudio);

    if size(audio,2) > 1
        audio = mean(audio,2);
    end

    sound(audio, fs);
    pause(length(audio)/fs + 0.5)

    % cliente = speechClient("whisper");
    % cliente.Language = idioma;

    texto = speech2text(audio, fs, Language=idioma);
    
    if istable(texto)
        texto = strjoin(texto.Transcript, " ");
    end

    disp("Transcripción:")
    disp(texto)
end
