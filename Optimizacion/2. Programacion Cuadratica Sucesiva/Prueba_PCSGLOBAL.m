% Script de prueba de PCSGLOBAL

maxp = 15;
npuntos = 2:maxp;

% Un estimado de la cota inferior del valor de f es 
%    f(x*) >= (1/2)*(npuntos^2)*(1-e),   0 <= e <= npuntos^(-1/2) 
% Fuente: https://www.mcs.anl.gov/~more/cops/bcops/elec.html
fmins.ub = 0.5*(npuntos.^2)';
fmins.lb = 0.5*((npuntos.^2).*(1 - sqrt(1./npuntos)))';

% Vectores para almacenar resultados
fvals = zeros(length(npuntos), 2);
iters = zeros(length(npuntos), 2);
times = zeros(length(npuntos), 2);
distx = zeros(length(npuntos), 1);

% Suppress warning:'optim:quadprog:HessianNotSym'
warning('off', 'optim:quadprog:HessianNotSym');

for np = npuntos
      
    x0 = randn(3*np, 1);
    x0(1:3) = eye(3,1);
    x0(4:6) = -eye(3,1);

    %% 1. Solución PCSGLOBAL
    [x1, ~, iters(np-1, 1)] = pcsglobal('fesfera', 'hesfera', x0);
    
    % Guardamos el valor objetivo optimo y el tiempo de ejecucion
    fvals(np-1, 1) = fesfera(x1);
    
    f = @() pcsglobal('fesfera', 'hesfera', x0);
    times(np-1, 1) = timeit(f, 3);
    %% 2. Solución MATLAB

    options = optimset('Algorithm', 'sqp', 'Display', 'off');
    options.MaxFunctionEvaluations = 1e+06;
    [x2, ~, ~, output] = fmincon('fesfera', x0,...
        [], [], [], [], [], [], 'hesfera', options);
    
    % Guardamos el numero de iteraciones, el valor objetivo optimo y
    % el tiempo de ejecucion
    iters(np-1, 2) = output.iterations;
    
    fvals(np-1, 2) = fesfera(x2);

    f = @() fmincon('fesfera', x0,...
        [], [], [], [], [], [], 'hesfera', options);
    times(np-1, 2) = timeit(f, 4);
    %% 3. Normalizamos y calculamos valores objetivos óptimos

    P0 = reshape(x0, [3, np]);
    P1 = reshape(x1, [3, np]); % Matriz solucion PCSGLOBAL
    P2 = reshape(x2, [3, np]); % Matriz solucion MATLAB

    % Volvemos cada punto de x0 un punto unitario
    for j = 1:np
       P0(:, j) = P0(:,j)/norm(P0(:,j));
    end

    % Redefinimos el punto x0
    x0 = reshape(P0, [3*np, 1]);
    
    % Distancia entre la sol. de MATLAB y de PCSGLOBAL
    distx(np-1) = norm(x1 - x2);

end

fprintf('\nSe han encontrado las soluciones para todos los valores de np\n\n')

%% 4. Tablas y gráficas de resultados

varnames = {'PCSGLOBAL', 'FMINCON'};
TFVALS = array2table(fvals, 'VariableNames', varnames,...
    'RowNames', string(npuntos));

fprintf('\nTabla de valores objetivos óptimos de PCSGLOBAL y FMINCON\n\n')
disp(TFVALS)

figResultados = figure('Name', 'Gráficas de resultados');
tab1 = uitab('Title', 'Número de iteraciones');
tab2 = uitab('Title', 'Tiempos de ejecución');
tab3 = uitab('Title', 'Distancia de las soluciones');

% Grafica iteraciones
axiters = axes(tab1);

plot(npuntos, iters(:, 1), 'LineWidth', 3, 'Marker', 'o',...
    'MarkerFaceColor', '#0072BD', 'Color', '#0072BD');
hold on
plot(npuntos, iters(:, 2), 'LineWidth', 3, 'Marker', 'o',...
    'MarkerFaceColor', '#A2142F', 'Color',	'#A2142F');
hold off
grid on

legend({'PCSGLOBAL', 'FMINCON'}, 'Location', 'northwest');

% Grafica tiempos de ejecucion
axftimes = axes(tab2);

plot(npuntos, times(:, 1), 'LineWidth', 3, 'Marker', 'o',...
    'MarkerFaceColor', '#0072BD', 'Color', '#0072BD');
hold on
plot(npuntos, times(:, 2), 'LineWidth', 3, 'Marker', 'o',...
    'MarkerFaceColor', '#A2142F', 'Color',	'#A2142F');
hold off
grid on

legend({'PCSGLOBAL', 'FMINCON'}, 'Location', 'northwest');

% Grafica distancia de las soluciones
axdist = axes(tab3);

plot(npuntos, distx, 'LineWidth', 3, 'Marker', 'o', 'Color',...
    '#7E2F8E', 'MarkerFaceColor', '#7E2F8E');
grid on

% Propiedades adicionales de los ejes
axiters.FontSize = 14;
axiters.Title.String = 'Número de iteraciones de PCSGLOBAL y FMINCON';
axiters.XLabel.String = 'n_p';
axiters.XTick = npuntos;
axiters.YLabel.String = 'Número de iteraciones';

axftimes.FontSize = 14;
axftimes.Title.String = 'Tiempos de ejecución de PCSGLOBAL y FMINCON';
axftimes.XLabel.String = 'n_p';
axftimes.XTick = npuntos;
axftimes.YLabel.String = {'Tiempo de ejecución', '(segundos)'};

axdist.FontSize = 14;
axdist.Title.String = 'Norma de la resta de las soluciones de PCSGLOBAL y FMINCON';
axdist.XLabel.String = 'n_p';
axdist.XTick = npuntos;
axdist.YLabel.String = '||x_1 - x_2||_2';

%% 5. Grafica de esferas con 21 puntos

figEsferas = figure('Name', 'Esferas');
tab1 = uitab('Title', 'Gráfica punto inicial');
tab2 = uitab('Title', 'Gráfica solución PCSGLOBAL');
tab3 = uitab('Title', 'Gráfica solución MATLAB');

% Construimos la grafica con el punto inicial
axP0 = axes(tab1);
sphere(axP0, 50);
hold on

for j = 1:maxp
    plot3(axP0, P0(1,j), P0(2,j), P0(3,j), 'Marker', 'o',...
        'LineWidth', 3, 'MarkerFaceColor', 'r',...
        'MarkerEdgeColor', 'r', 'MarkerSize', 8);
    hold on
end
hold off

axis equal

% Construmos la gráfica con la solucion de PCSGLOBAL
axP1 = axes(tab2);
sphere(axP1,50);
hold on

for j = 1:maxp
    plot3(axP1, P1(1,j), P1(2,j), P1(3,j), 'Marker', 'o',...
        'LineWidth', 3, 'MarkerFaceColor', 'r',...
        'MarkerEdgeColor', 'r', 'MarkerSize', 8);
    hold on
end
hold off

axis equal

% Construimmos la gráfica con la solucion de FMINCON
axP2 = axes(tab3);
sphere(axP2,50);
hold on

for j = 1:maxp
    plot3(axP2, P2(1,j), P2(2,j), P2(3,j), 'Marker', 'o',...
        'LineWidth', 3, 'MarkerFaceColor', 'r',...
        'MarkerEdgeColor', 'r', 'MarkerSize', 8);
    hold on
end
hold off

axis equal

% Propiedades adicionales de los ejes

axP0.Title.String = 'Puntos iniciales sobre la esfera';
axP0.XLabel.String = 'x';
axP0.XLabel.FontWeight = 'bold';
axP0.XLabel.FontSize = 14;

axP0.YLabel.String = 'y';
axP0.YLabel.FontWeight = 'bold';
axP0.YLabel.FontSize = 14;

axP0.ZLabel.String = 'z';
axP0.ZLabel.FontWeight = 'bold';
axP0.ZLabel.FontSize = 14;

axP1.Title.String = 'Puntos de la solución de PCSGLOBAL sobre la esfera';
axP1.XLabel.String = 'x';
axP1.XLabel.FontWeight = 'bold';
axP1.XLabel.FontSize = 14;

axP1.YLabel.String = 'y';
axP1.YLabel.FontWeight = 'bold';
axP1.YLabel.FontSize = 14;

axP1.ZLabel.String = 'z';
axP1.ZLabel.FontWeight = 'bold';
axP1.ZLabel.FontSize = 14;

axP2.Title.String = 'Puntos de la solución de FMINCON sobre la esfera';
axP2.XLabel.String = 'x';
axP2.XLabel.FontWeight = 'bold';
axP2.XLabel.FontSize = 14;

axP2.YLabel.String = 'y';
axP2.YLabel.FontWeight = 'bold';
axP2.YLabel.FontSize = 14;

axP2.ZLabel.String = 'z';
axP2.ZLabel.FontWeight = 'bold';
axP2.ZLabel.FontSize = 14;