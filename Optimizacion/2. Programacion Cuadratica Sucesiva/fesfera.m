function [f] = fesfera(x)
% fesfera Función de repulsion para n/3 puntos en la esfera 
% unitaria de dimensión 3.
%
% IN:   x ... vector con coordenadas de los puntos

    n = length(x);
    numpuntos = floor(n/3);
    f = 0;

    for i = 1:numpuntos-1

        ui = x(3*(i-1) + 1 : 3*i);

        for j = i+1:numpuntos

            uj = x(3*(j-1) + 1 : 3*j);
            f = f + 1/norm(ui - uj);

        end
    end

end

