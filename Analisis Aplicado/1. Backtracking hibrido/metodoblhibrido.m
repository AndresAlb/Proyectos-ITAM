function [x, iter] = metodoblhibrido(fname, x, dirNewton)

% Método híbrido de búsqueda de línea con la primer condición de Wolfe
% 20 de febrero de 2019.
% ITAM
% Análisis Aplicado
% Mauricio Trejo, Andrés Albores y Aarón López
%
% In
%   fname.- cadena de caracteres con el nombre de la función a minimizar
%   x.- vector n-dimensional
%   dirNewton.- variable binaria que dice si se utiliza la direccion de Newton
%   o la direccion de Maximo Descenso
% Out
%   x.- vector n-dimensional con la aproximación al mínimo local.
%   iter.- contador con el número final de iteraciones externas.
%
% Se requiere aproximaciones al gradiente en la función
% gradiente.m con el llamado:
%   g = gradiente (fname,x);

tol = 1.e-08;  % Tolerancia para la norma del gradiente.
c1 = 1e-04;    % Valor para la condición de Wolfe
maxiter = 250; % Número máximo de iteraciones externas permitidas
maxjter = 20;  % Número máximo de iteraciones internas de BL permitidas

iter = 0;               % Contador para las iteraciones externas
g = gradiente(fname, x);
ng = norm(g);
p = 1;

    %% Parte iterativa
    while ( ng > tol && iter < maxiter &&  norm(p) > 1e-04)
        
        if(dirNewton == true)
            H = hessiana(fname, x);
            [U, spd] = chol(H); % Fact. Cholesky: H = U'*U, U triang. superior
            if(spd == 0)
                U = U\eye(2, 2); % Invertimos U con fact. LU
                p = -(U*U')*g; % Calculamos la dir. de Newton con Cholesky
            else
                % H no es s.p.d. en ese punto
                p = -H\g;
            end
        else
            p = -g; % Direccion de maximo descenso
        end
        
        alfa = 1;               % Paso completo
        alfa2 = 1;              % Paso completo
        xt = x + alfa*p;        % Primer punto de prueba
        f  = feval(fname, x);   % Valor de la función
        f1 = feval(fname, xt);  % Valor de la función en el punto de prueba
        f2 = f1;                % Valor de la función en el punto de prueba
        s  = p'*g;              % Derivada direccional
        jter = 0;               % Iteraciones internas

        if( abs(s) < 1.e-06 )
            fprintf('\nNo hay suficiente descenso\n')
            %fprintf('Numero de iteraciones: %2.0f', iter)
            %fprintf('\nDerivada direccional: %2.10f\n', s)
            return;
        end

        %% Búsqueda de línea
        while(f1 > f + alfa*c1*s && f2 > f + alfa2*c1*s && jter < maxjter)

            % Backtracking simple
            alfa = alfa/2;

            % Interpolación cuadrática
            d2 = f2 - f - s;
            alfa2 = s/(2*d2);

            % Selección de alfa
            if(f1 <= f + alfa*c1*s)
                if(f2 <= f + alfa2*c1*s)
                    % Backtracking e interpolación cuadrática cumplen Wolfe 1
                    alfa = max(alfa, alfa2);
                end
            else
                % Sólo interpolación cuadrática cumple Wolfe 1
                if(f2 <= f + alfa2*c1*s)
                    alfa = alfa2;
                end
            end

            % Actualización
            xt = x + alfa*p;
            f1 = feval(fname, xt);
            xt = x + alfa2*p;
            f2 = feval(fname, xt);
            jter = jter + 1;

        end
    
    if(jter >= 20 || norm(alfa*p) < 1e-3)
        alfa = 1e-2;
    end
    
        % Actualización de valores
        x = x + alfa*p;
        g = gradiente(fname, x);
        iter = iter + 1;

    end
end


