function dist = levenshteinDistance(refTokens, hypTokens)
% LEVENSHTEINDISTANCE Calcula la distancia de edición entre dos secuencias.
%   DIST = LEVENSHTEINDISTANCE(REFTOKENS, HYPTOKENS) devuelve el número
%   mínimo de operaciones necesarias para transformar la secuencia
%   REFTOKENS en HYPTOKENS. Las operaciones permitidas son inserciones,
%   eliminaciones y sustituciones. Ambas entradas deben ser cell arrays de
%   cadenas (tokens) previamente tokenizados.
%
%   Este algoritmo implementa el método clásico de programación dinámica
%   para la distancia de Levenshtein.
%
%   Ejemplo:
%       ref = {'hola','mundo'};
%       hyp = {'hola','cruel','mundo'};
%       d = levenshteinDistance(ref, hyp)
%       % devuelve 1 (una inserción)

    R = numel(refTokens);
    H = numel(hypTokens);

    dp = initializeDP(R, H);

    for i = 2:R+1
        for j = 2:H+1
            cost = ~strcmp(refTokens{i-1}, hypTokens{j-1});
            dp(i,j) = min([
                dp(i-1,j) + 1,      % deletion
                dp(i,j-1) + 1,      % insertion
                dp(i-1,j-1) + cost  % substitution
            ]);
        end
    end

    dist = dp(R+1, H+1);
end