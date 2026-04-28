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

    nReferencia = numel(refTokens);
    nHipotesis = numel(hypTokens);

    dp = initializeDP(nReferencia, nHipotesis);

    for i = 2:nReferencia+1
        for j = 2:nHipotesis+1
            
            costeSustitucion = ~strcmp(refTokens{i-1}, hypTokens{j-1}); % 1 ó 0
            
            dp(i,j) = min([

                dp(i-1,j) + 1,      % coste tras eliminar un 'token'
                dp(i,j-1) + 1,      % coste tras añadir un 'token'
                dp(i-1,j-1) + costeSustitucion

            ]);
        end
    end

    dist = dp(nReferencia+1, nHipotesis+1);
end