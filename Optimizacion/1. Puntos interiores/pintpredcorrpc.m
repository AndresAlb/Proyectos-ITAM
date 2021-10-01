function [x, y, u, fval, iter] = pintpredcorrpc(Q, A, c, b)
% pintpredcorrpc Método de puntos interiores predictor-corrector 
% para resolver el problema
%   
%           minimizar   (1/2)*x'*Q*x + c'*x 
%           sujeto a    A*x >= b
%                
% IN:       Q ... matriz simétrica positiva definida de n x n
%           A ... matriz de m x n de rango m (m <= n)
%           c ... vector columna de n x 1
%           b ... vector columna de m x 1
% 
% OUT:      x ... vector columna de n x 1 que representa la 
%                 solución del problema. El vector es vacío si 
%                 el problema es no-factible.
%           u ... vector columna de m x 1 que contiene los 
%                 valores de los multiplicadores de Lagrange. El 
%                 vector es vacío si el problema es no-factible.
%           y ... vector columna de m x 1 que representa 
%                 variables de holgura. El vector es vacío si el
%                 problema es no-factible.
%        fval ... número real que representa el valor óptimo de 
%                 la función objetivo. El valor asignado es NaN
%                 si el problema es no-factible.
%        iter ... número de iteraciones.
%
% @author: Andres Angeles

    %% 1. Definición de parametros iniciales
    tol = 1e-05;
    maxiter = 200;
    iter = 0;
    [m, n] = size(A);

    %% 2. Definición de variables iniciales
    
    % Resolvemos el prob. auxiliar 
    %
    %   minimizar  sum(z)
    %   sujeto a   A*x0 - z >= b
    %              z >= 0
    %
    % cuya solución para x0 = zeros(n, 1) es z = max(b(i), 0)
    % para i = 1, 2, ..., m (Nocedal, p.473) para determinar  
    % si el problema es factible o no
        
    z = max([b, zeros(size(b))], [], 2);
    
    if(sum(z) > 0)
    
        % Problema no-factible
        x = [];
        y = [];
        u = [];
        fval = nan;
        return
    
    end

    x = zeros(n, 1);
    y = ones(m, 1);
    u = ones(m, 1);

    %% 3. Definición de matriz F
    F = [Q*x - A'*u + c; A*x - y - b; y.*u];

    %% 4. Iteración
    while(norm(F) > tol && iter < maxiter)

        %% 5. Paso Predictor
        
        % 5.1 Definimos residuos y otras matrices
        Y = diag(y);
        U = diag(u);        
        invY = Y\eye(m);
        Rx = F(1:n);
        Ry = F((n + 1):(n + m));
        Ru = F((n + m + 1):end);
        tau = (y'*u)/m;
        
        % 5.2 Calculamos las matrices del sistema reducido
        G = Q + A'*invY*U*A;
        R = Rx + (A'*invY*U)*Ry + (A'*invY)*Ru;
        
        % 5.3 Calculamos los pasos predictores
        dx_pred = -G\R;
        dy_pred = A*dx_pred + Ry;
        du_pred = -invY*(U*dy_pred + Ru);

        % 5.4 Calculamos el recorte del paso
        a = recortarPaso(y, u, dy_pred, du_pred);
        
        % 5.5 Calculamos el parámetro de centrado
        tau_pred = (y + a*dy_pred)'*(u + a*du_pred)/m;
        s = (tau_pred/tau)^3; 
        
        %% 6. Paso corrector
        
        % 6.1 Corregimos el residuo Ru 
        Ru = F((n + m + 1):end) + dy_pred.*du_pred - s*tau;
        
        % 6.2 Calculamos las matrices del sistema reducido corregido
        G = Q + A'*invY*U*A;
        R = Rx + (A'*invY*U)*Ry + (A'*invY)*Ru;
        
        % 6.3 Calculamos los pasos corregidos
        dx = -G\R;
        dy = A*dx + Ry;
        du = -invY*(U*dy + Ru);
        
        % 6.4 Calculamos el recorte del paso
        a = recortarPaso(y, u, dy, du);

        % 6.5 Nuevo punto 
        x = x + a*dx;
        y = y + a*dy;
        u = u + a*du;

        % 6.6 Redefinir sistema F
        F = [Q*x - A'*u + c; A*x - y - b; y.*u];
        iter = iter + 1;
        
    end
    
    %% 7. Calculamos el valor de la función obj. en el pto. óptimo
    fval = 0.5*(x'*Q*x) + c'*x;

end



