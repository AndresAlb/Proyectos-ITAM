
% Script para probar la función PINT 

%% 1. Ejemplo 7.7 de Engineering Optimization de Singoresu Rao

% minimizar  f(x1, x2) = (1/3)*(x1 + 1)^3 + x2
% sujeto a   g1(x1, x2) = -x1 + 1 <= 0
%            g2(x1, x2) = -x2 <= 0
%
% x* = [1; 0]

clearvars;
clc;
x0 = [1.2; 0.6];
[x, fval, iter] = pint('f77', 'g77', x0);

%% 2. Ejemplo 7.8 de Engineering Optimization de Singoresu Rao

% minimizar f(x) = x1^3 - 6*x1^2 + 11*x1 + x3
% sujeto a  g1(x) = x1^2 + x2^2 - x3 <= 0
%           g2(x) = 4 - x1^2 - x2^2 - x3^2 <= 0
%           g3(x) = x3 - 5 <= 0
%           x1, x2, x3 <= 0
%
% x* = [0; sqrt(2); sqrt(2)]

x0 = [0; sqrt(2); sqrt(2)] + 0.3;
[x, fval, iters] = pint('f78', 'g78', x0);
