function [x, y, iter] = pcsglobal(f, h, x0)
% pcsglobal Resuelve el problema
%
%           minimizar f(x)
%           sujeto a  h(x) = 0
%
% mediante el algoritmo de programación cuadrática sucesiva con
% actualización BFGS
% 
% IN:       f ... cadena de carácteres que representa el nombre de 
%                 la función objetivo del problema
%           h ... cadena de carácteres que representa el nombre de
%                 la función de restricciones del problema
%          x0 ... vector de dimensión n x 1 que representa una 
%                 aproximación de la solución del problema
%
% OUT:      x ... vector de dimensión n x 1 que representa la 
%                 solución del problema
%           y ... vector de dimensión m x 1 que contiene los 
%                 multiplicadores de Lagrange asociados con x
%        iter ... número de iteraciones que realiza el algoritmo
%
% @author: Andres Angeles

    %% 1. Definimos parametros iniciales
    n = length(x0);
    tol = 1e-05;
    steptol = 1e-02;
    maxiter = 200;
    iter = 0;
    t = 1e-02;
    options = optimoptions(@quadprog, 'Display', 'off');
    
    %% 3. Condiciones necesarias de primer orden
    
    % Gradiente y jacobianas de f y h
    [~, hx] = feval(h, x0);
    Gf = gradiente(f, x0);
    Jh = jacobiana(h, x0);
    
    % Multiplicador de Lagrange
    Q = 2*(Jh*Jh');
    b = 2*Jh*Gf;
    y = -Q\b;
    
    CNPO = [Gf + Jh'*y; hx];
    
    %% 2. Definimos valores iniciales
    x = x0;
    B = 2*eye(n);
    
    %% 4. Iteracion
    while(norm(CNPO) > tol && iter < maxiter)
    
        % 4.1 Resolver subproblema cuadratico
        [p, ~, ~, ~, ~] = quadprog(B, Gf, [], [], Jh, -hx,...
            [], [], [], options);
        
        % 4.2 Determinar parámetro c
        
        % Buscamos c* tal que la derivada direccional de la funcion
        % de merito L1 sea negativa para c > c*
        c = 0.1 + abs(Gf'*p)/norm(hx, 1);
        
        % 4.3 Búsqueda de línea
        a = 1;
        while(meritoL1(x + a*p, c) > meritoL1(x, c) + a*t*meritoDDL1(x, p, c))
            a = 0.5*a;
        end
        
        if(norm(a*p) < steptol)
            % El nuevo punto será casi idéntico al anterior. La 
            % actualizacion BFGS-Powell podría no estar bien
            % definida si s = x - x0 = 0 y s'*r = 0
            return
        end
        
        % 4.4 Calculamos el nuevo punto x y recalculamos matrices
        x0 = x;
        x = x0 + a*p;
        Gf0 = gradiente(f, x0);
        Jh0 = jacobiana(h, x0);
        Gf = gradiente(f, x);
        Jh = jacobiana(h, x);
        
        % 4.5 Recalcular el multiplicador de Lagrange
        Q = 2*(Jh*Jh');
        b = 2*Jh*Gf;
        y = -Q\b;
        
        % 4.6 Actualización BFGS-Powell
        s = x - x0; % Ya sabemos que s > 0 
        u = (Gf + Jh'*y) - (Gf0 + Jh0'*y);
        
        aux = s'*B*s;
        if(s'*u > 0.2*aux)
            r = u;
        else
            % Actualizar r
            theta = (0.2*aux - s'*u)/(aux - s'*u);
            r = theta*B*s + (1-theta)*u;
        end
        
        B = B + (r*r')/(s'*r) - (B*(s*s')*B)/aux;
        
        if(rcond(B) < 1e-06)
            % B está mal condicionada, asi que la redefinimos
            B = norm(CNPO)*eye(n);  
        end
        
        % 4.7 Redefinir CNPO
        [~, hx] = feval(h, x);
        CNPO = [Gf + Jh'*y; hx];
        iter = iter + 1;
    
    end
end

