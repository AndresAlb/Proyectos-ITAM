
% Este script usa la funcion mSimplexFaseII para resolver N problemas
% generados de manera aleatoria. En cada vuelta, se guardan el minimo 
% entre las dimensiones del problema min(m,n), el numero de iteraciones 
% y una variable booleana que indica si el problema tenia solucion o no

N = 5; % Numero de problemas que se quieren generar

res = zeros(N, 3);
res(:, 3) = false;

for i = 1:N
    % Generar dimensiones del problema 
    m = round(10*exp(log(20)*rand())); 
    n = round(10*exp(log(20)*rand()));
    
    % Generar A, b, c 
    sigma = 100; 
    A = round(sigma*randn(m,n)); 
    b = round(sigma*abs(randn(m,1))); 
    c = round(sigma*randn(n,1));
    
    % Llamamos a la funcion mSimplexFaseII y resolvemos el problema
    [~, ~, ban, iter] = mSimplexFaseII(A, b, c, false);
    
    % Guardamos los resultados que nos interesan
    if ban == 0
        res(i, :) = [min(m,n), iter, true];
    else
        res(i, 1:2) = [min(m,n), iter];
    end   
end
