function [W, H, fval] = descenso2pasos(X, k)
% descenso2pasos Resuelve el problema de factorización no-negativa
% de una matriz en la norma de Frobenius mediante el Método de 
% descenso en coordenadas
%
% IN:    X ... matriz de dimensión r x p
%        k ... número entero tal que k << r y k << p
%
% OUT:   W ... matriz con entradas no-negativas de dimensión r x k
%        H ... matriz con entradas no-negativas de dimensión k x p
%        fval ... valor final de la función objetivo  
%
% Prob. de factorización no-negativa para H
%
%   Queremos resolver el problema (en Norma F):
%             min.  |X - W*H|²
%               s.a.  H >= 0
%   Sean x(j) y h(j) las j-ésimas columnas de X y H, entonces 
%   el problema se divide en p problemas de la forma:
%               min. |x(j) - W*h(j)|²
%               s.a. h(j) >= 0
%   donde |•| es ahora la norma-2, entonces
%       |x(j) - W*h(j)|² = (x(j) - W*h(j))'*(x(j)- W*h(j))
%       = x(j)'*x(j) - 2*x(j)'*(W*h(j)) + (W*h(j))'*(W*h(j))
%       = x(j)'*x(j) + (W*h(j))'*(W*h(j)) - 2*x(j)'*(W*h(j))
%       = x(j)'*x(j) + q(y)
%   donde
%       q(y) = (W*h(j))'*(W*h(j)) - 2*x(j)'*(W*h(j))
%            = h(j)'*(W'*W)*h(j) - 2*(W'*x(j))'*h(j)
%            = (1/2)*h(j)'*(2*W'*W)*h(j) - 2*(W'*x(j))'*h(j)
%   es una función cuadrática con Q = 2*W'*W, c = -2*W'*x(j)
%   y y = h(j)
%
% Prob. de factorización no-negativa para W        
%
%   Queremos resolver el problema (en Norma F):
%               min.  |X - W*H|²
%               s.a.  W >= 0
%   Sean x(i) y w(i) las i-ésimas filas de X y W, entonces 
%   el problema se divide en r problemas de la forma:
%               min. |x(i) - H'*w(i)|²
%               s.a. w(i) >= 0
%    donde |•| es ahora la norma-2,  entonces
%       |x(i) - H'*w(i)|² = (x(i) - H'*w(i))'*(x(i)- H'*w(i))
%       = x(i)'*x(i) + (H'*w(i))'*(H'*w(i)) - 2*x(i)'*(H'*w(i))
%       = x(i)'*x(i) + q(y)
%   donde
%       q(y) = (H'*w(i))'*(H'*w(i)) - 2*x(i)'*(H'*w(i))
%            = w(i)'*(H*H')*w(i) - 2*(H*x(i))'*w(i)
%            = (1/2)*w(i)'*(2*H*H')*w(i) - 2*(H*x(i))'*w(i)
%   es una función cuadrática con Q = 2*H*H', c = -2*H*x(i)
%   y y = w(i)
%
% @author: Andres Angeles

    %% 1. Definir parámetros
    [r, p] = size(X);
    
    % Cambiamos el modo 'Display' de quadprog a 'iter' para que
    % nos de más detalles de cada iteración
    % options = optimoptions(@quadprog, 'Display', 'iter');
    
    % Cambiamos el modo 'Display' de quadprog a 'off' para que
    % no arroje mensajes cada vez
    options = optimoptions(@quadprog, 'Display', 'off');
    fprintf("\nComprimiendo imagen. Espere...\n\n")

    %% 2. Definir las matrices iniciales W0 y H0
    W0 = 0.8*ones(r, k);
    H0 = 0.8*ones(k, p);
    W = W0;
    H = H0;

    %% 3. Iteración
    for iter = 1:k
        
        % 3.1 Resolver el prob. de factorización no-negativa para H
        Q = 2*(W0'*W0);
        
        for j = 1:p
            x = X(:, j);
            c = -2*(W0'*x);
            A = -eye(k);
            b = zeros(k, 1);
            H(:, j) = quadprog(Q, c, A, b, [],[],[],[],[], options);
        end
        
        % 3.2 Resolver el prob. de factorización no-negativa para W
        Q = 2*(H*H');

        for i = 1:r
            x = X(i, :)';
            c = -2*(H*x);
            A = -eye(k);
            b = zeros(k, 1);
            W(i, :) = quadprog(Q, c, A, b, [],[],[],[],[], options);
        end
        
        W0 = W;
        
    end
    
    fprintf("La compresión ha terminado exitosamente.\n\n")

    fval = norm(X - W*H, 'fro')^2;
end

