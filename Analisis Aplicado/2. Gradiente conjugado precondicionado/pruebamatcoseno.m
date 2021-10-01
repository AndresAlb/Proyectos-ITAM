%script pruebamatcoseno
% Mauricio Trejo Santamaria 138886
% Andrés Albores Ángeles 131749

close all

n = 1000;
MC = zeros(n,n);
b = ones(n,1);
for i=1:n
    for j=1:n
        if i==j
            MC(i,j) = sqrt(i);
        else
           if j == i+10 || i == j+10
                MC(i,j) = cos(i);
            end 
        end
    end
end

% Utilizamos la descompocisión SVD para obtener una matriz
% diagonal con la que el método pueda actuar.
[U,S,V] = svd(MC);
b = U\b;
t0 = cputime;
[AA,ind] = almcomren(S);
t0 = cputime - t0;

%Gradiente conjugado
t1 = cputime;
[x,iter,band,vecres] = GC(AA,ind,b);
t1 = cputime - t1;
x = V'\x;

%Gradiente conjugado precondicionado
v = sqrt(diag(S));     % vector para el precondicionador
C = diag(v);            % precondicionador
t2 = cputime;
[x1, iter1, band1, vecres1] = GCPre(AA,ind,C,b);
t2 = cputime - t2;
x1 = V'\x1;
% Grafica de resultados
xaxis = 1:length(vecres);
xaxis1 = 1:length(vecres1);

plot(xaxis,vecres,'-r*',xaxis1,vecres1,'--b*')
set(gca, 'YScale', 'log')
title('Matriz Coseno')
xlabel('Número de iteraciones')
ylabel('Norma residual')
legend('GC','GCPre')

fprintf('almcomren.m %s \n',t0)
fprintf('GC.m %s GCPre.m %d \n',t1,t2)