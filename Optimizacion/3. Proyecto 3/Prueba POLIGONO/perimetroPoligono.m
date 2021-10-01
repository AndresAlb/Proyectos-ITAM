function [p] = perimetroPoligono(R, A)
% PERIMETROPOLIGONO Calcula el perimetro del poligono definido por las
% coordenadas polares de R y A
% 
% IN:    R ... vector columna de dimensi�n n x 1 cuyas entradas 
%              representan los radios de los v�rtices del pol�gono
%        A ... vector columna de dimensi�n n x 1 cuyas entradas
%              representan los �ngulos de los v�rtices del pol�gono
% 
% OUT:   p ... perimetro del pol�gono
% 
% @author: Andres Angeles 

R1 = R(1:end);
R2 = [R(2:end); R(1)];
A1 = A(1:end);
A2 = [A(2:end); A(1)];

p = sum(sqrt(R1.^2 + R2.^2 - 2*R1.*R2.*cos(A2 - A1)));

end

