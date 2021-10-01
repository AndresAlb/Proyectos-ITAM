function [p] = perimetroPoligono(x)
% PERIMETROPOLIGONO Calcula el perimetro del poligono definido por las
% coordenadas polares de R y A
% 
% IN:   x0 ... vector columna de dimensión n x 1 cuyas entradas 
%              representan las coordenadas polares de los vértices 
%              del polígono
% 
% OUT:   p ... perimetro del polígono
% 
% @author: Andres Angeles 

n = length(x);
R1 = [0; x(2:n/2)];
R2 = [x(2:n/2); 0];
A1 = [0; x(n/2+2:end)];
A2 = [x(n/2+2:end); 0];

p = -sum(sqrt(R1.^2 + R2.^2 - 2*R1.*R2.*cos(A2 - A1)));

end

