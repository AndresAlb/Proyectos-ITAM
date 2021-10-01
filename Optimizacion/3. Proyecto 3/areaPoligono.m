function [a] = areaPoligono(x)
% AREAPOLIGONO Calcula el area del poligono definido por las
% coordenadas polares de R y A
% 
% IN:    x ... vector columna de dimensión n x 1 cuyas entradas 
%              representan las coordenadas polares de los vértices
%              del polígono
% 
% OUT:   a ... area del polígono
% 
% @author: Andres Angeles 

n = length(x);
R1 = [0; x(2:n/2)];
R2 = [x(2:n/2); 0];
A1 = [0; x(n/2+2:end)];
A2 = [x(n/2+2:end); 0];

a = -0.5*R1'*(R2.*sin(A2 - A1));

end

