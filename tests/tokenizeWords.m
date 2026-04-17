function tokens = tokenizeWords(sentence)
% TOKENIZEWORDS Divide una frase en palabras en minúsculas.
%   TOKENS = TOKENIZEWORDS(SENTENCE) devuelve un array con las palabras
%   extraídas de SENTENCE. La función convierte el texto a minúsculas,
%   elimina espacios en blanco al inicio y al final, y separa la frase por
%   espacios para producir tokens simples, adecuados para tareas de
%   procesamiento de lenguaje.
%
%   Ejemplo:
%       tokenizeWords("  Hola Mundo  ")
%       % devuelve {'hola', 'mundo'}

    normalizedSentence = lower(strtrim(sentence));
    tokens = strsplit(normalizedSentence);

end
