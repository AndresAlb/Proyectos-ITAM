
% Problemas de prueba para la funcion mSimplexFaseII

% 1 Ejemplos de clase

    fprintf("\n1 Ejemplos de clase\n");

    % 1.1 Problema acotado con conjunto factible no-vacio
    
    % Solucion: z* = -36, B = {1,2,3}, x* = (2,6,2)
    fprintf("\n1.1 Problema acotado con conjunto factible no-vacio\n");
    A = [1 0; 0 2; 3 2]; b = [4; 12; 18]; c = [-3; -5];
    [x0, z0, ban, iter] = mSimplexFaseII(A, b, c, false)

    % 1.2 Problema con SBF degenerada
    
    % Solucion: z* = -2, B = {1,2}, x* = (2,2)
    % SBF degenerada en el estado 0
    fprintf("\n1.2 Problema con SBF degenerada en el estado 0\n");
    A = [-1 1; 1 0]; b = [0; 2]; c = [0; -1];
    [x0, z0, ban, iter] = mSimplexFaseII(A, b, c, false)
    
    % 1.3 Problema no acotado
    
    % No acotado en la 1ra iteracion
    fprintf("\n1.3 Problema no acotado en la 1ra iteracion\n");
    A = [1 -1; -1 1]; b = [1; 2]; c = [-1; 0];
    [x0, z0, ban, iter] = mSimplexFaseII(A, b, c, false)
    
% 2 Vanderbei 

    fprintf("\n2 Vanderbei: ejercicios con soluciones\n");

    % 2.1 Problema acotado de maximizacion con conjunto
    % factible no vacio
    
    % Solucion: z* = 17, B = {1,3}, x* = (2,0,1,0)
    fprintf(['\n2.1 Problema de maximizacion acotado con conjunto'...
        ' factible no-vacio\n']);
    A = [2 1 1 3; 1 3 1 2]; b = [5; 3]; c = [6; 8; 5; 9]; c = -c;
    [x0, z0, ban, iter] = mSimplexFaseII(A, b, c, false)
    
    % 2.2 Problema de maximizacion con conjunto factible vacio
    
    fprintf(['\n2.2 Problema de maximizacion con conjunto'... 
        ' factible vacio\n']);
    A = [-1 -1; -1 1; 1 2]; b = [-3; -1; 2]; c = [1; 3]; c = -c;
    [x0, z0, ban, iter] = mSimplexFaseII(A, b, c, false)
    
% 3 Luenberger

    fprintf("\n3 Ejemplos Luenberger\n");

    % 3.1 Problema de maximizacion acotado con conjunto factible no-vacio
    
    % Solucion: z* = 27/5, B = {1,3,6}, x* = (1/5, 8/5, 4)
    fprintf(['\n3.1 Problema de maximizacion acotado con conjunto '... 
        'factible no-vacio\n']);
    A = [2 1 1; 1 2 3; 2 2 1]; b = [2; 5; 6]; c = [3; 1; 3]; c = -c;
    [x0, z0, ban, iter] = mSimplexFaseII(A, b, c, true)
    
