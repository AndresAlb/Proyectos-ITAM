function [l1] = meritoL1(x, c)
% L1 Calcula el valor de la función de mérito L1 de las 
% funciones 'fesfera' y 'hesfera' en el punto x con constante c > 0
%
% La función de mérito L1 está dada por la ecuación
%   
%           L1(x, c) = f(x) + c*|h(x)|
%
% donde |•| es la norma-1
%
% IN:       x ... vector n x 1 que contiene las coordenadas del  
%                 punto que debe ser evaluado
%           c ... constante positiva
%
% OUT:     l1 ... valor de la función de mérito L1 evaluada en 
%                 el punto x
%
% @author: Andres Angeles

fx = fesfera(x);
[~, hx] = hesfera(x);

l1 = fx + c*norm(hx, 1);

end

