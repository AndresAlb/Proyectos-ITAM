function [Jf] = jacobiana(f,x0)
% JACOBIANA Calcula la matriz jacobiana de f en x0

    n = length(x0);
    [f0, ~] = feval(f, x0);
    m = length(f0);

    Jf = zeros(m, n);
    e = 1e-05;
    for j = 1:n
        y = x0;
        y(j) = y(j) + e;
        [fy, ~] = feval(f, y);
        Jf(:, j) = (fy - f0)/e;
    end

end

