% Script de prueba de punintpc

options = optimoptions(@quadprog, 'Display', 'off');
iters = zeros(12, 3);
t = zeros(12, 3);
sols = cell(12, 3);
fvals = cell(12, 3);

%% 1. Ejemplo 4.16 de Engineering Optimization de Singoresu Rao

% *Ejercico modificado: cambiamos la restricción A*x <= b
% a la forma -A*x >= -b a la hora de introducirlo a quadprog
% y punintpc
%
% Resolver utilizando MATLAB:
%
%       minimizar x1^2 + 2*x2^2 - 2*x1*x2 - 4*x1
%       sujeto a  2*x1 + x2 <= 6
%                 x1 - 4*x2 <= 0
% 

Q = [2, -2; -2, 4];
c = [-4; 0];
A = [2, 1; 1, -4];
b = [6; 0];

[sols{1,1}, fvals{1,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(1,1) = output.iterations;
[sols{1,2}, ~, ~, fvals{1,2}, iters(1,2)] = punintpc(Q, -A, c, -b);
[sols{1,3}, ~, ~, fvals{1,3}, iters(1,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(1,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(1,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(1,3) = timeit(f3);

%% 2. Ejemplo 16.2 de Nocedal (p.453)

% El problema es de igualdad estricta A*x = b, pero aquí lo
% utilizo como un problema con desigualdad A*x >= b.
% 
%       minimizar q(x)
%       sujeto a  A*x = b
% 

Q = [6, 2, 1; 2, 5, 2; 1, 2, 4];
c = [-8; -3; -3];
A = [1, 0, 1; 0, 1, 1];
b = [3; 0];

[sols{2,1}, fvals{2,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(2,1) = output.iterations;
[sols{2,2}, ~, ~, fvals{2,2}, iters(2,2)] = punintpc(Q, -A, c, -b);
[sols{2,3}, ~, ~, fvals{2,3}, iters(2,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(2,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(2,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(2,3) = timeit(f3);

%% 3. Ejemplo 16.4 de Nocedal (p.475)

% min.  q(x) = (x1 - 1)² + (x2 - 5/2)²
% s.a.  x1 - 2*x2 >= -2
%      -x1 - 2*x2 >= -6
%      -x1 + 2*x2 >= -2
%       x1, x2 >= 0
%
% q(x) = (1/2)*(2*x1^2 + 2*x2^2) - 2*x1 - 5*x2 + (29/4)
% => q(x) - 29/4 = (1/2)*(2*x1^2 + 2*x2^2) - 2*x1 - 5*x2
%
% Valor óptimo: x* = [1.4; 1.7]

Q = [2, 0; 0, 2];
c = [-2; -5];
A = [1, -2; -1, -2; -1, 2; 1, 0; 0, 1];
b = [-2; -6; -2; 0; 0];

[sols{3,1}, fvals{3,1}, ~, output] = quadprog(Q, c, -A, -b, [], [],...
    [], [], [], options);
iters(3,1) = output.iterations;
[sols{3,2}, ~, ~, fvals{3,2}, iters(3,2)] = punintpc(Q, A, c, b);
[sols{3,3}, ~, ~, fvals{3,3}, iters(3,3)] = pintpredcorrpc(Q, A, c, b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, -A, -b, [], [], [], [], [], options);
t(3,1) = timeit(f1);
f2 = @() punintpc(Q, A, c, b);
t(3,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, A, c, b);
t(3,3) = timeit(f3);

%% 4. Ejercicio 4.48 de Engineering Optimization de Singoresu Rau

% Resolver utilizando MATLAB:
%
%        maximizar  q(x) = 2*x1 + x2 - x1^2
%        sujeto a   2*x1 + 3*x2 <= 6
%                   2*x1 + x2 <= 4
%                   x1, x2 >= 0

Q = [-2, 0; 0, 0];
c = [2; 1];
A = [2, 3; 2, 1; -1, 0; 0, -1];
b = [6; 4; 0; 0];

[sols{4,1}, fvals{4,1}, ~, output] = quadprog(-Q, -c, A, b, [], [],...
    [], [], [], options);
iters(4,1) = output.iterations;
[sols{4,2}, ~, ~, fvals{4,2}, iters(4,2)] = punintpc(-Q, -A, -c, -b);
[sols{4,3}, ~, ~, fvals{4,3}, iters(4,3)] = pintpredcorrpc(-Q, -A, -c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(-Q, -c, A, b, [], [], [], [], [], options);
t(4,1) = timeit(f1);
f2 = @() punintpc(-Q, -A, -c, -b);
t(4,2) = timeit(f2);
f3 = @() pintpredcorrpc(-Q, -A, -c, -b);
t(4,3) = timeit(f3);

%% 5. Ejercicio 4.49 de Engineering Optimization de Singoresu Rau

% Resolver utilizando MATLAB:
%
%        maximizar  q(x) = 4*x1 + 6*x2 - x1^2 - x2^2
%        sujeto a   x1 + x2 <= 2
%                   x1, x2 >= 0
%

Q = [-2, 0; 0, -2];
c = [4; 6];
A = [1, 1; -1, 0; 0, -1];
b = [2; 0; 0];

[sols{5,1}, fvals{5,1}, ~, output] = quadprog(-Q, -c, A, b, [], [],...
    [], [], [], options);
iters(5,1) = output.iterations;
[sols{5,2}, ~, ~, fvals{5,2}, iters(5,2)] = punintpc(-Q, -A, -c, -b);
[sols{5,3}, ~, ~, fvals{5,3}, iters(5,3)] = pintpredcorrpc(-Q, -A, -c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(-Q, -c, A, b, [], [], [], [], [], options);
t(5,1) = timeit(f1);
f2 = @() punintpc(-Q, -A, -c, -b);
t(5,2) = timeit(f2);
f3 = @() pintpredcorrpc(-Q, -A, -c, -b);
t(5,3) = timeit(f3);

%% 6. Ejercicio 4.50 de Engineering Optimization de Singoresu Rau

% *Ejercicio modificado: quité una restricción de igualdad
% 
% Resolver utilizando MATLAB:
%
%        minimizar  q(x) = (x1 - 1)² + x2 - 2
%        sujeto a   x1 + x2 <= 2
%                   x1, x2 >= 0
%
% q(x) = x1^2 - 2*x1 + x2 - 1 => q(x) + 1 = x1^2 - 2*x1 + x2

Q = [2, 0; 0, 1];
c = [-2; 1];
A = [1, 1; -1, 0; 0, -1];
b = [2; 0; 0];

[sols{6,1}, fvals{6,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(6,1) = output.iterations;
[sols{6,2}, ~, ~, fvals{6,2}, iters(6,2)] = punintpc(Q, -A, c, -b);
[sols{6,3}, ~, ~, fvals{6,3}, iters(6,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(6,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(6,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(6,3) = timeit(f3);

%% 7. Ejercicio 4.51 de Engineering Optimization de Singoresu Rau

% Resolver utilizando MATLAB:
%
%        minimizar  q(x) = x1^2 + x2^2 - 3*x1*x2 - 6*x1 + 5*x2
%        sujeto a   x1 + x2 <= 4
%                   3*x1 + 6*x2 <= 20
%                   x1, x2 >= 0

Q = [2, -3; -3, 2];
c = [-6; 5];
A = [1, 1; 3, 6; -1, 0; 0, -1];
b = [4; 20; 0; 0];

[sols{7,1}, fvals{7,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(7,1) = output.iterations;
[sols{7,2}, ~, ~, fvals{7,2}, iters(7,2)] = punintpc(Q, -A, c, -b);
[sols{7,3}, ~, ~, fvals{7,3}, iters(7,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(7,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(7,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(7,3) = timeit(f3);

%% 8. Ejercicio 4.51 de Engineering Optimization de Singoresu Rau

% Resolver utilizando MATLAB:
%
%        minimizar  q(x) = x1^2 + x2^2 - 3*x1*x2 - 6*x1 + 5*x2
%        sujeto a   x1 + x2 <= 4
%                   3*x1 + 6*x2 <= 20
%                   x1, x2 >= 0

Q = [2, -3; -3, 2];
c = [-6; 5];
A = [1, 1; 3, 6; -1, 0; 0, -1];
b = [4; 20; 0; 0];

% Volvemos el problema infactible usando -A y -b
[sols{8,1}, fvals{8,1}, ~, output] = quadprog(Q, c, -A, -b, [], [],...
    [], [], [], options);
iters(8,1) = output.iterations;
[sols{8,2}, ~, ~, fvals{8,2}, iters(8,2)] = punintpc(Q, A, c, b);
[sols{8,3}, ~, ~, fvals{8,3}, iters(8,3)] = pintpredcorrpc(Q, A, c, b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, -A, -b, [], [], [], [], [], options);
t(8,1) = timeit(f1);
f2 = @() punintpc(Q, A, c, b);
t(8,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, A, c, b);
t(8,3) = timeit(f3);

%% 9. AFIRO

load 'Problemas de prueba/afiro'

Q = eye(length(c));

[sols{9,1}, fvals{9,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(9,1) = output.iterations;
[sols{9,2}, ~, ~, fvals{9,2}, iters(9,2)] = punintpc(Q, -A, c, -b);
[sols{9,3}, ~, ~, fvals{9,3}, iters(9,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(9,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(9,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(9,3) = timeit(f3);

%% 10. GROW7

load 'Problemas de prueba/grow7'

Q = eye(length(c));

[sols{10,1}, fvals{10,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(10,1) = output.iterations;
[sols{10,2}, ~, ~, fvals{10,2}, iters(10,2)] = punintpc(Q, -A, c, -b);
[sols{10,3}, ~, ~, fvals{10,3}, iters(10,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(10,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(10,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(10,3) = timeit(f3);

%% 11. SCTAP1

load 'Problemas de prueba/sctap1'

Q = eye(length(c));

[sols{11,1}, fvals{11,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(11,1) = output.iterations;
[sols{11,2}, ~, ~, fvals{11,2}, iters(11,2)] = punintpc(Q, -A, c, -b);
[sols{11,3}, ~, ~, fvals{11,3}, iters(11,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(11,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(11,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(11,3) = timeit(f3);

%% 12. BOEING1

load 'Problemas de prueba/boeing1'

Q = eye(length(c));

[sols{12,1}, fvals{12,1}, ~, output] = quadprog(Q, c, A, b, [], [],...
    [], [], [], options);
iters(12,1) = output.iterations;
[sols{12,2}, ~, ~, fvals{12,2}, iters(12,2)] = punintpc(Q, -A, c, -b);
[sols{12,3}, ~, ~, fvals{12,3}, iters(12,3)] = pintpredcorrpc(Q, -A, c, -b);

% Tomamos el tiempo de ejecución de cada función
f1 = @() quadprog(Q, c, A, b, [], [], [], [], [], options);
t(12,1) = timeit(f1);
f2 = @() punintpc(Q, -A, c, -b);
t(12,2) = timeit(f2);
f3 = @() pintpredcorrpc(Q, -A, c, -b);
t(12,3) = timeit(f3);

%% 11. Tablas de resultados

rownames = {'Problema 1', 'Problema 2', 'Problema 3',...
    'Problema 4', 'Problema 5', 'Problema 6',...
    'Problema 7', 'Problema 8', 'AFIRO', 'GROW7',...
    'SCTAP1', 'BOEING1'};
varnames = {'QUADPROG', 'PUNINTPC', 'PINTPREDCORRPC'};

RESTIME = array2table(t, 'VariableNames', varnames,...
    'RowNames', rownames);
RESITERS = array2table(iters, 'VariableNames', varnames,...
    'RowNames', rownames);
RESFVALS = cell2table(fvals, 'VariableNames', varnames,...
    'RowNames', rownames);

fprintf(['\nTabla con tiempos promedio de ejecución '...
    'de cada función en cada problema\n\n'])
disp(RESTIME);
fprintf(['\nTabla con el número de iteraciones que realiza '...
    'cada función en cada problema\n\n'])
disp(RESITERS)
fprintf(['\nTabla con los valores óptimos de cada función'...
    ' objetivo en cada problema\n\n'])
disp(RESFVALS)

% Guardamos las tablas en archivos txt
writetable(RESTIME,...
    'Tablas de resultados/TablaTiemposEjecucion.txt',...
    'Delimiter', ' ');

writetable(RESITERS,...
    'Tablas de resultados/TablaNumeroIteraciones.txt',...
    'Delimiter', ' ');

writetable(RESFVALS,...
    'Tablas de resultados/TablaValoresObjetivoOptimos.txt',...
    'Delimiter', ' ');