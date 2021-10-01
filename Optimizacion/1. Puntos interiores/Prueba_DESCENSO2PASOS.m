% Script de prueba de descenso2pasos

format long g % Imprimir números con más entradas decimales

%% 1. Prueba CLOWN
load clown
map = colormap('gray');
imwrite(X, map, 'Imagenes/Clown.jpg');

K = [3, 5, 20, 30, 60, 80];
fvals = zeros(size(K));

fprintf('\n\n############## CLOWN ##############\n')

for i = 1:length(K)
    
    [W, H, fvals(i)] = descenso2pasos(X, K(i));
    str = sprintf('Imagenes/Clown_%diters.jpg', K(i));
    imwrite(W*H, str);
    
end

aux = [4.50, 4.75, 6.10, 6.51, 7.38, 7.74, 8.63];
imsizes = aux(1:length(K));

RESCLOWN = table(K', imsizes', fvals',...
    'VariableNames', {'Iteraciones', 'Tamaño (KB)', '||X - W*H||'});

disp(RESCLOWN)
%writetable(RESCLOWN,...
%   'Tablas de resultados/TablaResultadosClown.txt', 'Delimiter', ' ');

%% 2. Prueba Cardiff Castle

X = imread('Imagenes/CardiffCastle.jpg');

% Convertir matriz de uint8 a double
X = im2double(X);
% Convertir imagen a blanco y negro
X = rgb2gray(X);
% Guardar imagen en blanco y negro
imwrite(X, 'Imagenes/CardiffCastleBW.jpg');

K = [3, 5, 20, 30, 60, 80];
fvals = zeros(size(K));

fprintf('\n\n############## CARDIFF CASTLE ##############\n')

for i = 1:length(K)
    
    [W, H, fvals(i)] = descenso2pasos(X, K(i));
    str = sprintf('Imagenes/CardiffCastle_%diters.jpg', K(i));
    imwrite(W*H, str);
    
end

aux = [140, 159, 219, 238, 265, 278, 316];
imsizes = aux(1:length(K));

RESCARDIFFCASTLE = table(K', imsizes', fvals',...
    'VariableNames', {'Iteraciones', 'Tamaño (KB)', '||X - W*H||'});

disp(RESCARDIFFCASTLE)
% writetable(RESCARDIFFCASTLE,...
%     'Tablas de resultados/TablaResultadosCardiffCastle.txt',...
%     'Delimiter', ' ');

format % Volvemos el formato al modo preestablecido