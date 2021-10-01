
% Script para solucionar el problema del poligono con PINT

numV = 6; % Número de vértices

%% 1. Construcción del círculo y el polígono x0 en coordenadas polares
step = 0.08;
circle.theta = 0:step:2*pi;
circle.rho = 0.5*cos(circle.theta - pi/2)...
    + sqrt(0.25 - 0.25*sin(circle.theta - pi/2).^2);

if 2*numV >= length(circle.theta)
   warning('El número de vértices excede el número máximo de vértices permitido.')
   numV = 6;
end

i = 1:2:2*numV;
x0 = [circle.theta(i)'; circle.rho(i)'];

%% 2. Maximización perímetro

[x_per, fval, iter] = pint('perimetroPoligono', 'restriccionesPoligono', x0);
x_per(1) = 0;
x_per(numV+1) = 0;

%% 3. Maximización área 

[x_area, fval, iter] = pint('areaPoligono', 'restriccionesPoligono', x0);
x_area(1) = 0;
x_area(numV+1) = 0;

%% 3. Gráficas de resultados

figResultados = figure('Name', 'Gráficas de resultados');
tab1 = uitab('Title', 'Polígono inicial');
tab2 = uitab('Title', 'Polígono con perímetro máximo');
tab3 = uitab('Title', 'Polígono con área máxima');

% Gráfica del polígono inicial x0
axPInicial = axes(tab1);

polarplot(circle.theta, circle.rho, 'LineWidth', 3)
hold on
polarplot(circle.theta([i, i(1)]), circle.rho([i, i(1)]),...
    'LineWidth', 3, 'Marker', '.', 'MarkerSize', 30)
hold off

thetalim([0, 180])

% Gráfica del polígono solución
axPPer = axes(tab2);

thetaX = [x_per(numV+1:end); x_per(numV+1)];
rhoX = [x_per(1:numV); x_per(1)];

polarplot(circle.theta, circle.rho, 'LineWidth', 3)
hold on
polarplot(thetaX, rhoX, 'LineWidth', 3, 'Marker', '.',...
    'MarkerSize', 30)
hold off

thetalim([0, 180])

% Gráfica del polígono solución
axPArea = axes(tab3);

thetaX = [x_area(numV+1:end); x_area(numV+1)];
rhoX = [x_area(1:numV); x_area(1)];

polarplot(circle.theta, circle.rho, 'LineWidth', 3)
hold on
polarplot(thetaX, rhoX, 'LineWidth', 3, 'Marker', '.',...
    'MarkerSize', 30)
hold off

thetalim([0, 180])