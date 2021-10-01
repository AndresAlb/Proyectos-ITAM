function [H] = hessiana(fname,x)
% Aproximacion de la hessiana 
% de una funcion  de R^n a R.

% In
%   fname .- cadena con el nombre de la funcion.
%   x .- vector columna de dimension n.
% Out
%   H - es la aproximación a la matriz hessiana en x.

h = 1.e-06;
n = length(x);
H = zeros(n);
fx = feval(fname,x);

for i=1:n
    x1 = x; x1(i) = x1(i) + h;
    f1 = feval(fname,x1);
    for j=i:n
        x2 = x; x2(j) = x2(j) + h; f2 = feval(fname,x2);
        x3 = x1; x3(j) = x3(j) + h; f3 = feval(fname,x3);
        H(i,j) = (f3 - f2 - f1 + fx)/(h^2);
        H(j,i) = H(i,j);
    end
end

end

