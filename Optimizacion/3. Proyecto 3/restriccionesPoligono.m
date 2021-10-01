function [C, Ceq] = restriccionesPoligono(x)
% RESTRICCIONESPOLIGONO Calcula el valor de las restricciones del
% problema del pol�gono para el pol�gono definido por las coordenadas
% polares de R y A
% 
% IN:    x ... vector columna de dimensi�n n x 1 cuyas entradas 
%              representan las coordenadas polares de los v�rtices del
%              pol�gono
% 
% OUT:   C ... vector columna que contiene el valor de las restricciones 
%              de desigualdad C(x) >= 0
%      Ceq ... vector columna que contiene el valor de las restricciones de 
%              igualdad Ceq(x) = 0
% 
% @author: Andres Angeles

    C = [];
    Ceq = [];

    n = length(x);
    R1 = [0; x(2:n/2)];
    R2 = [x(2:n/2); 0];
    A1 = [0; x(n/2+2:end)];
    A2 = [x(n/2+2:end); 0];

    %% 1. Distancia entre v�rtices consecutivos
    dV = sqrt(R1.^2 + R2.^2 - 2*R1.*R2.*cos(A2 - A1));
    C = [C; 1 - dV];
    C = [C; dV - 1/n];

    %% 2. Distancia entre �ngulos de vertices consecutivos
    dA = A2(1:end-1) - A1(1:end-1);
    C = [C; dA];

    %% 3. Factibilidad de los angulos
    C = [C; x(n/2+1:end)];
    C = [C; pi - x(n/2+1:end)];
    
    % Exijo que el �ngulo correspondiente al v�rtice inicial theta(1)
    % satisfaga que theta(1) >= 0 y -theta(1) >= 0, es decir, 
    % que mantenga el v�rtice inicial en el cero.
    %C = [C; -x(n/2 + 1)]; 

    %% 3. Factibilidad de los radios
    C = [C; x(1:n/2)];
    C = [C; 1-x(1:n/2)];
    
    % Exijo que el radio correspondiente al v�rtice inicial rho(1)
    % satisfaga que rho(1) >= 0 y -rho(1) >= 0, es decir, 
    % que mantenga el v�rtice inicial en el cero.
    %C = [C; -x(n/2)];

end

