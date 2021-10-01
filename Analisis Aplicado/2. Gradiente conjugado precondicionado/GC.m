function [x,iter,band,vecres] = GC(AA,ind,b)

% M�todo de gradiente conjugado con matriz almacenada por
% por compresi�n en los renglones.
% El vector x es la aproximaci�n a la soluci�n.
% El �ndice iter es el n�mero de iteraciones.
% El vector vecres es el vector de residuales ||A*x_k - b||
% La tolerancia para el residual es tol = 1.e-06
% El n�mero m�ximo de iteraciones es maxiter = n
% El valor band indica:
%   band == 1 si y s�lo si ||A*x_k - b|| < tol
%   band == 0 si y s�lo si iter = maxiter y ||A*x_k - b|| > tol

% Mauricio Trejo Santamaria 138886
% Andr�s Albores �ngeles 131749

tol = 1.e-06;                   % tolerancia para ||r||
n = length(b);                  % dimensi�n del problema
x = ones(n,1);
band = 0;

r = matporvec(AA,ind,x) - b;    % primer residual
vecres = [];                    % vector de residuales

p = -r;                         % primer direcci�n conjugada
maxiter = n;                    % n�mero m�ximo de iteraciones
iter = 0;                       % contador de iteraciones

while(norm(r) >= tol && iter < maxiter)
    
    numerador = r'*r;
    Ap = matporvec(AA,ind,p);
    denominador = p'*Ap;
    alpha = numerador/denominador;         % minimizaci�n a lo largo de p_k
    x = x + alpha*p;                       % nuevo punto
    rn = r + alpha*Ap;                     % nuevo residual
    beta = (rn'*rn)/(numerador);           % valor de beta
    
    r = rn;
    p = -r + beta*p;              % nueva direcci�n    
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

