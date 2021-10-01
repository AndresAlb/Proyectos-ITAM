% prueba poisson
% Mauricio Trejo Santamaria 138886
% Andrés Albores Ángeles 131749

close all

m = 25;
MP = gallery('poisson',m);
t0 = cputime;
[AA,ind] = almcomren(full(MP));
t0 = cputime - t0;
b = ones(m*m,1);

%Gradiente conjugado
t1 = cputime;
[x,iter,band,vecres] = GC(AA,ind,b);
t1 = cputime - t1;

%Gradiente conjugado precondicionado
v = sqrt(diag(MP));     % vector para el precondicionador
C = diag(v);            % precondicionador
t2 = cputime;
[x1, iter1, band1, vecres1] = GCPre(AA,ind,C,b);
t2 = cputime - t2;

% Grafica de resultados
xaxis = 1:length(vecres);
xaxis1 = 1:length(vecres1);

plot(xaxis,vecres,'-r*',xaxis1,vecres1,'--b*')
set(gca, 'YScale', 'log')
title('Matriz de Poisson')
xlabel('Número de iteraciones')
ylabel('Norma residual')
legend('GC','GCPre')

fprintf('almcomren.m %s \n',t0)
fprintf('GC.m %s GCPre.m %d \n',t1,t2)