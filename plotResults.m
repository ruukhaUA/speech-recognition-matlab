function plotResults(werValuesWord, werValuesChar)

    meanWERWord = mean(werValuesWord);
    meanWERChar = mean(werValuesChar);

    % Esta gráfica muestra la distribución del error WER a nivel de palabra.
    % Permite observar si la mayoría de los audios tienen bajo error o si existen muchos casos con errores altos.
    
    figure
    set(gcf, 'Color', 'w')
    histogram(werValuesWord)
    title('Distribución WER (palabras)')
    xlabel('WER')
    ylabel('Frecuencia')
    grid on
    saveas(gcf, 'HistogramaPalabra.png')
    close(gcf)

    % Distribución del error WER a nivel de carácter.
    % Esta métrica es más estricta, por lo que permite analizar
    % errores más finos en la transcripción.
    
    figure
    set(gcf, 'Color', 'w')
    histogram(werValuesChar)
    title('Distribución WER (caracteres)')
    grid on
    saveas(gcf, 'HistogramaCaracter.png')
    close(gcf)

    % Comparación directa entre WER por palabra y por carácter para cada audio. 
    % Permite ver en qué casos el modelo falla más y cómo difieren ambas métricas.

    figure
    set(gcf, 'Color', 'w')
    x = 1:length(werValuesWord);
    plot(x, werValuesWord, 'o-')
    hold on
    plot(x, werValuesChar, 'x-')
    legend('Palabra','Caracter')
    title('Comparación WER')
    xlabel('Audio')
    ylabel('Error')
    grid on
    saveas(gcf, 'Comparacion.png')
    close(gcf)

    % Representación del error medio global del sistema.
    % Resume el rendimiento general del modelo en ambas métricas.
    
    figure
    set(gcf, 'Color', 'w')
    bar([meanWERWord, meanWERChar])
    set(gca, 'XTickLabel', {'Palabra','Caracter'})
    title('WER medio')
    ylabel('Error')
    grid on
    saveas(gcf, 'Media.png')
    close(gcf)

    % Boxplot para analizar la dispersión del error y detectar outliers.
    % Permite identificar audios problemáticos con errores elevados.

    figure
    set(gcf, 'Color', 'w')
    boxplot([werValuesWord(:), werValuesChar(:)], ...
        'Labels', {'Palabra','Caracter'})
    title('Distribución del error')
    ylabel('WER')
    grid on
    saveas(gcf, 'Boxplot.png')
    close(gcf)

    % Error WER por cada archivo de audio.
    % Útil para localizar ejemplos concretos donde el modelo falla más.

    figure
    set(gcf, 'Color', 'w')
    bar(werValuesWord)
    title('WER por audio')
    xlabel('Audio')
    ylabel('WER')
    grid on
    saveas(gcf, 'WERporAudio.png')
    close(gcf)

end
