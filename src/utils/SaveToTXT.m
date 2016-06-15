%% PROGRAMA PARA ESCRIBIR EN UN FICHERO DE TEXTO 

% open the file with write permission
fid = fopen('c:/Displayer/test.txt', 'w');

for i=1:3
   
str1 = int2str(i);
str = strcat('C:/Displayer/Test/', str1, '.jpg');
fprintf(fid, '%s\n', str);

end

fclose(fid);
