function dp = initializeDP(R, H)
% INITIALIZEDP  Crea e inicializa la matriz de programación dinámica.
%
%   dp = INITIALIZEDP(R, H)
%
%   Devuelve una matriz (R+1)-por-(H+1) utilizada en el cálculo de la
%   distancia de edición o WER. La primera columna se inicializa con
%   0:R para representar borrados, y la primera fila con 0:H para
%   representar inserciones.
%
%   Parámetros
%   ----------
%   R : entero
%       Número de tokens en la secuencia de referencia.
%
%   H : entero
%       Número de tokens en la secuencia hipótesis.
%
%   Devuelve
%   --------
%   dp : matriz numérica
%       Matriz de programación dinámica inicializada para el algoritmo.
%

    dp = zeros(R+1, H+1);

    dp(:,1) = 0:R;   % borrados
    dp(1,:) = 0:H;   % inserciones
end