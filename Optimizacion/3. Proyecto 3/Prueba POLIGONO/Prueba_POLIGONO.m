% Script para probar las funciones del problema del
% poligono

%% 1. Poligono clase

X = [0, 2, 2, 0, -2, -2];
Y = [0, 1, 3, 6, 3, 1];

[A, R] = cart2pol(X, Y);

A = A';
R = R';

a = areaPoligono(R, A);
p = perimetroPoligono(R, A);
[C, Ceq] = restriccionesPoligono(R, A);

%% 2. Cuadrado

X = [0, 2, 2, 0, -2, -2];
Y = [0, 1, 3, 6, 3, 1];

[A, R] = cart2pol(X, Y);

A = A';
R = R';

a = areaPoligono(R, A);
p = perimetroPoligono(R, A);
[C, Ceq] = restriccionesPoligono(R, A);

