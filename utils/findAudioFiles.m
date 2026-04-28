function audioFiles = findAudioFiles(dirPath)
% FINDAUDIOFILES  Devuelve una lista de rutas completas a archivos de audio.
%
%   audioFiles = FINDAUDIOFILES(dirPath)
%
%   Busca de forma recursiva todos los archivos de audio válidos dentro del
%   directorio especificado. Se consideran válidas las extensiones:
%   .wav, .mp3, .flac, .m4a
%
%   Parámetros
%   ----------
%   dirPath : string o char
%       Ruta al directorio donde buscar los archivos de audio.
%
%   Devuelve
%   --------
%   audioFiles : cell array de strings
%       Lista de rutas completas a cada archivo de audio encontrado.
%
%   Ejemplo
%   -------
%       archivos = listarAudios("audio/");
%
%   Notas
%   -----
%   - La función ignora subdirectorios ocultos y archivos sin extensión válida.
%   - Se puede ampliar la lista de extensiones modificando la variable 'validExt'.
%

    validExtensions = {".wav", ".mp3", ".flac", ".m4a"};

    everythingInPath = dir(fullfile(dirPath, "*.*")); % Obtenemos todos los contenidos de la carpeta
    audioFiles = {};

    for k = 1:numel(everythingInPath)

        [~, ~, extension] = fileparts(everythingInPath(k).name);

        if ismember(string(lower(extension)), string(validExtensions)) % Filtramos sólo los archivos con extensión válida
            
            audioFiles{end+1} = fullfile(dirPath, everythingInPath(k).name);
        end
    end
end

