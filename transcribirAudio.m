function texto = transcribirAudio(rutaAudio, idioma)
    [audio, fs] = audioread(rutaAudio);

    if size(audio,2) > 1
        audio = mean(audio,2);
    end

    sound(audio, fs);
    pause(length(audio)/fs + 0.5)

    cliente = speechClient("wav2vec2.0");
    cliente.Language = idioma;

    texto = speech2text(audio, fs, Client=cliente);

    disp("Transcripción:")
    disp(texto)
end