
% Este script genera y resuelve el problema de Klee-Minty de 
% dimension m = 3, 4,..., 10 usando la funcion generaKleeMinty y
% mSimplexFaseII para medir el tiempo y el numero de iteraciones
% que realiza el metodo en cada caso

M = 10;

iter = 3:M;
t = 3:M;

for m = 3:M
    [A, b, c] = generaKleeMinty(m);
    tic;
    [~, ~, ~, iter(m-2)] = mSimplexFaseII(A, b, c, false);
    t(m-2) = toc;
end

format; % Restablece el formato de impresion de MATLAB

fprintf("\n          m:");
disp(3:M);
fprintf("\nIteraciones:");
disp(iter);
fprintf("\n     Tiempo:");
disp(t);

scatter(3:M, t, 120, 'o', 'filled');
set(gca, 'xlim', [3, 11], 'fontsize', 20); 
ylabel('Tiempo', 'fontname', 'Segoe UI Light', 'fontsize', 30); 
xlabel('Dimension', 'fontname', 'Segoe UI Light', 'fontsize', 30); 
grid on
