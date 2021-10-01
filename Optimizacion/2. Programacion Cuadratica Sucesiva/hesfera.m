function [g, h] = hesfera(x)
% hesfera Función de restricciones del problema de np puntos en
% la esfera unitaria de dimensión 3

    n = length(x);
    numpuntos = floor(n/3);
    
    h = zeros(numpuntos, 1); % Restricciones de igualdad
    g = []; % Restricciones de desigualdad

    for j = 1:numpuntos

        uj = x(3*(j-1) + 1 : 3*j);
        h(j) = uj'*uj - 1;

    end

end

