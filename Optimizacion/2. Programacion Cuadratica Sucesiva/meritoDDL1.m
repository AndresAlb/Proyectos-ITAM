function [dl1] = meritoDDL1(x, p, c)
% L1 Calcula el valor de la derivada direccional de la función de 
% mérito L1 de las funciones 'fesfera' y 'hesfera' en el punto x 
% con constante c > 0
%
% La derivada direccional de la función de mérito L1 está dada por 
% la ecuación
%   
%           DL1(p, c) = Gf(x) - c*|h(x)|
%
% donde Gf(x) es el gradiente de f evaluado en el punto x y 
% |•| es la norma-1
%
% IN:       x ... vector n x 1 que contiene las coordenadas del  
%                 punto que debe ser evaluado
%           p ... vector n x 1 que representa el paso para la 
%                 derivada direccional
%           c ... constante positiva
%
% OUT:     dl1 ... valor de la derivada direccional de la función
%                 de mérito L1 en el punto x
%
% @author: Andres Angeles

[~, hx] = hesfera(x);
Gfx = gradiente('fesfera', x);

dl1 = Gfx'*p - c*norm(hx, 1);

end