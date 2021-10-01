function [x,iter,band,vecres] = GC(AA,ind,b)

% Método de gradiente conjugado con matriz almacenada por
% por compresión en los renglones.
% El vector x es la aproximación a la solución.
% El índice iter es el número de iteraciones.
% El vector vecres es el vector de residuales ||A*x_k - b||
% La tolerancia para el residual es tol = 1.e-06
% El número máximo de iteraciones es maxiter = n
% El valor band indica:
%   band == 1 si y sólo si ||A*x_k - b|| < tol
%   band == 0 si y sólo si iter = maxiter y ||A*x_k - b|| > tol

% Mauricio Trejo Santamaria 138886
% Andrés Albores Ángeles 131749

tol = 1.e-06;                   % tolerancia para ||r||
n = length(b);                  % dimensión del problema
x = ones(n,1);
band = 0;

r = matporvec(AA,ind,x) - b;    % primer residual
vecres = [];                    % vector de residuales

p = -r;                         % primer dirección conjugada
maxiter = n;                    % número máximo de iteraciones
iter = 0;                       % contador de iteraciones

while(norm(r) >= tol && iter < maxiter)
    
    numerador = r'*r;
    Ap = matporvec(AA,ind,p);
    denominador = p'*Ap;
    alpha = numerador/denominador;         % minimización a lo largo de p_k
    x = x + alpha*p;                       % nuevo punto
    rn = r + alpha*Ap;                     % nuevo residual
    beta = (rn'*rn)/(numerador);           % valor de beta
    
    r = rn;
    p = -r + beta*p;              % nueva dirección    
    vecres = [vecres norm(r)];    % actualización de vector residual
    
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

