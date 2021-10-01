function [x, fval, iter] = pint(f, g, x0)
% PINT Método de puntos interiores para resolver el problema
%   
%           minimizar  f(x)
%           sujeto a   g(x) >= 0
%
% donde f y g son funciones no-lineales.
%                
% IN:       f ... cadena de caracteres que representa el nombre de
%                 la función objetivo del problema.
%           g ... cadena de caracteres que representa el nombre de
%                 la función de restricciones del problema.
%          x0 ... vector columna de n x 1 que representa una
%                 aproximación de la solución del problema.
% 
% OUT:      x ... vector columna de n x 1 que representa la 
%                 solución del problema.
%           u ... vector columna de m x 1 que contiene los 
%                 valores de los multiplicadores de Lagrange.
%           z ... vector columna de m x 1 que representa 
%                 variables de holgura.
%        fval ... número real que representa el valor óptimo de 
%                 la función objetivo.
%        iter ... número de iteraciones.
%
% @author: Andres Angeles

    %% 1. Definición de parametros y derivadas en x0
    tol = 1e-05;
    steptol = 1e-09;
    maxiter = 200;
    iter = 0;
    
    [gx, ~] = feval(g, x0);
    Gf = gradiente(f, x0);
    Jg = jacobiana(g, x0);
    
    [p, n] = size(Jg);

    %% 2. Definición de variables iniciales
    x = x0;
    z = ones(p, 1);
    u = ones(p, 1);
    B = eye(n);

    %% 3. Definición de Conds. Necesarias de 1er Orden
    gamma = 0.5*(z'*u)/p;
    CNPO = [Gf + Jg'*u; gx - z; u.*z];

    %% 4. Iteración
    while(norm(CNPO) > tol && iter < maxiter)

        % 4.1 Definimos las matrices del sistema
        Z = diag(z);
        U = diag(u);
        JF = [B,         Jg',      zeros(n, p); 
            Jg,         zeros(p),  -eye(p);
            zeros(p, n), U,         Z];
        R = CNPO;
        R((n + p + 1):end) = R((n + p + 1):end) - gamma;
        
        % 4.2 Resolvemos el sistema
        D = -JF\R;
        dx = D(1:n);
        du = D(n+1:n+p);
        dz = D(n+p+1:end);
        
        % 4.3 Recortamos el paso
        a = recortarPaso(z, u, dz, du);
        
        % 4.4 Calculamos el nuevo punto y recalculamos derivadas
        x0 = x;
        x = x + a*dx;
        z = z + a*dz;
        u = u + a*du;
        
        if(norm(a*dx) < steptol)
            % El paso es demasiado chico, por lo que la actualización 
            % BFGS podría no estar bien definida
            fval = feval(f, x);
            return
        end
        
        Gf0 = gradiente(f, x0);
        Jg0 = jacobiana(g, x0);
        Gf = gradiente(f, x);
        Jg = jacobiana(g, x);
        
        % 4.5 Actualización BFGS-Powell
        s = x - x0;
        y = (Gf + Jg'*u) - (Gf0 + Jg0'*u);
        
        aux = s'*B*s;
        if(s'*y > 0.2*aux)
            r = y;
        else
            theta = (0.2*aux - s'*y)/(aux - s'*y);
            r = theta*B*s + (1-theta)*y;
        end
        
        B = B + (r*r')/(s'*r) - (B*(s*s')*B)/aux;
        
        if(rcond(B) < 1e-06)
            % B está mal condicionada, asi que la redefinimos
            B = norm(CNPO)*eye(n);  
        end
        
        % 4.6 Redefinimos CNPO 
        [gx, ~] = feval(g, x0);
        gamma = 0.5*(z'*u)/p;
        CNPO = [Gf + Jg'*u; gx - z; u.*z];
        iter = iter + 1;
        
    end

    %% 7. Calculamos el valor de la función obj. en el pto. óptimo
    fval = feval(f, x);
    
end



