function tokens = tokenize(sentence, mode)
% TOKENIZE Tokeniza una frase en palabras o caracteres.
%   TOKENS = TOKENIZE(SENTENCE, MODE) devuelve un cell array de tokens.
%   MODE puede ser:
%       'word'  – tokenización por palabras
%       'char'  – tokenización por caracteres

    normalized = lower(strtrim(sentence));

    switch mode
        case 'word'
            tokens = strsplit(normalized);

        case 'char'
            tokens = cellstr(regexp(normalized, '.', 'match'));

        otherwise
            error("Modo de tokenización no reconocido: %s", mode);
    end
end