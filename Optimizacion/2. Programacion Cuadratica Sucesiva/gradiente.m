function [Gf] = gradiente(f, x0)
% gradiente Calcula por diferencias hacia adelante el gradiente de
% f: R^n -> R en el punto x0
%
% Gf(k) = (parcial de f)/(parcial de x(k))  

    n = length(x0);
    Gf = zeros(n, 1);
    e = 1e-05;
    f0 = feval(f, x0);

    for k = 1:n

        x0(k) = x0(k) + e;
        Gf(k) = (feval(f, x0) - f0)/e;
        x0(k) = x0(k) - e;
        
    end

end