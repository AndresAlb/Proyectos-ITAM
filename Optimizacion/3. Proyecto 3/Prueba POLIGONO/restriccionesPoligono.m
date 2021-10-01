function [C, Ceq] = restriccionesPoligono(R, A)
% RESTRICCIONESPOLIGONO Calcula el valor de las restricciones del
% problema del polígono para el polígono definido por las coordenadas
% polares de R y A
% 
% IN:    R ... vector columna de dimensión n x 1 cuyas entradas 
%              representan los radios de los vértices del polígono
%        A ... vector columna de dimensión n x 1 cuyas entradas
%              representan los ángulos de los vértices del polígono
% 
% OUT:   C ... vector columna que contiene el valor de las restricciones 
%              de desigualdad C(x) >= 0
%      Ceq ... vector columna que contiene el valor de las restricciones de 
%              igualdad Ceq(x) = 0
% 
% @author: Andres Angeles

C = [];
Ceq = [];

if ~all(size(R) == size(A))
    Warning('Input dimensions must be equal.')
    return
end

n = length(R);
R1 = R(1:end);
R2 = [R(2:end); R(1)];
A1 = A(1:end);
A2 = [A(2:end); A(1)];

%% 1. Distancia entre vértices consecutivos
dV = sqrt(R1.^2 + R2.^2 - 2*R1.*R2.*cos(A2 - A1));
C = [C; 1 - dV];
C = [C; dV - 1/n];

%% 2. Distancia entre ángulos de vertices consecutivos
dA = A2(1:end-1) - A1(1:end-1);
C = [C; dA];

%% 3. Factibilidad de los angulos
C = [C; A];
C = [C; pi - A];

%% 3. Factibilidad de los radios
C = [C; R];
C = [C; 1-R];

end

