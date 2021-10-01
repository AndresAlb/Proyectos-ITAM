
% Script para solucionar el problema del poligono con PINT

numV = 6; % N�mero de v�rtices

%% 1. Construcci�n del c�rculo y el pol�gono x0 en coordenadas polares
step = 0.08;
circle.theta = 0:step:2*pi;
circle.rho = 0.5*cos(circle.theta - pi/2)...
    + sqrt(0.25 - 0.25*sin(circle.theta - pi/2).^2);

if 2*numV >= length(circle.theta)
   warning('El n�mero de v�rtices excede el n�mero m�ximo de v�rtices permitido.')
   numV = 6;
end

i = 1:2:2*numV;
x0 = [circle.theta(i)'; circle.rho(i)'];

%% 2. Maximizaci�n per�metro

[x_per, fval, iter] = pint('perimetroPoligono', 'restriccionesPoligono', x0);
x_per(1) = 0;
x_per(numV+1) = 0;

%% 3. Maximizaci�n �rea 

[x_area, fval, iter] = pint('areaPoligono', 'restriccionesPoligono', x0);
x_area(1) = 0;
x_area(numV+1) = 0;

%% 3. Gr�ficas de resultados

figResultados = figure('Name', 'Gr�ficas de resultados');
tab1 = uitab('Title', 'Pol�gono inicial');
tab2 = uitab('Title', 'Pol�gono con per�metro m�ximo');
tab3 = uitab('Title', 'Pol�gono con �rea m�xima');

% Gr�fica del pol�gono inicial x0
axPInicial = axes(tab1);

polarplot(circle.theta, circle.rho, 'LineWidth', 3)
hold on
polarplot(circle.theta([i, i(1)]), circle.rho([i, i(1)]),...
    'LineWidth', 3, 'Marker', '.', 'MarkerSize', 30)
hold off

thetalim([0, 180])

% Gr�fica del pol�gono soluci�n
axPPer = axes(tab2);

thetaX = [x_per(numV+1:end); x_per(numV+1)];
rhoX = [x_per(1:numV); x_per(1)];

polarplot(circle.theta, circle.rho, 'LineWidth', 3)
hold on
polarplot(thetaX, rhoX, 'LineWidth', 3, 'Marker', '.',...
    'MarkerSize', 30)
hold off

thetalim([0, 180])

% Gr�fica del pol�gono soluci�n
axPArea = axes(tab3);

thetaX = [x_area(numV+1:end); x_area(numV+1)];
rhoX = [x_area(1:numV); x_area(1)];

polarplot(circle.theta, circle.rho, 'LineWidth', 3)
hold on
polarplot(thetaX, rhoX, 'LineWidth', 3, 'Marker', '.',...
    'MarkerSize', 30)
hold off

thetalim([0, 180])