function [x, iter, band, vecres] = GCPre(AA,ind,C,b)
% Se resuelve el sistema lineal A*x = b por medio de 
% gradiente conjugado usando el precondicionador de 
% Jacobi, i.e. M = C'*C

% Mauricio Trejo Santamaria 138886
% Andr�s Albores �ngeles 131749

tol = 1.e-06;                   % tolerancia para ||r||
n = length(b);                  % dimensi�n del problema
maxiter = n;                    % m�ximo de iteraciones
x = ones(n,1);                 
r = matporvec(AA,ind,x) - b;    % primer residual
vecres = [];                    % vector de residuales
iter = 0;
band = 0;

M = C'*C;       % Calculo de la matriz M
y = M\r;        % Resolver el sistema lineal M*y = r

p = -r;         % primera direcci�n de descenso

while (norm(r) > tol && iter < maxiter)
    
    numerador = r'*y;
    Ap = matporvec(AA,ind,p);
    denominador = p'*Ap;
    alpha = numerador/denominador;
    
    x = x + alpha*p;
    r_nueva = r + alpha*Ap;
    
    y_nueva = M\r_nueva;    % Resolviendo el sistema lineal
    
    beta = (r_nueva'*y_nueva)/(r'*y);
    p = -y_nueva + beta*p;
    
    y = y_nueva;
    r = r_nueva;
    vecres = [vecres norm(r)];    % actualizaci�n de vector residual
    
    iter = iter + 1;
end

if norm(r) < tol
    band = 1;
else
    if iter == maxiter
        band = 0;
    end
end

end

