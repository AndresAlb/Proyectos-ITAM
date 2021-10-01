# Proyecto 1

El objetivo es hacer búsqueda de línea híbrida con backtracking e interpolación cuadrática para evitar pasos largos y cortos.

Supongamos que 

<a href="https://www.codecogs.com/eqnedit.php?latex=f(x&plus;p)&space;>&space;f(x)&space;&plus;&space;c_1&space;\nabla&space;f(x)^Tp" target="_blank"><img src="https://latex.codecogs.com/gif.latex?f(x&plus;p)&space;>&space;f(x)&space;&plus;&space;c_1&space;\nabla&space;f(x)^Tp" title="f(x+p) > f(x) + c_1 \nabla f(x)^Tp" /></a>

entonces calcuamos dos vectores:

<a href="https://www.codecogs.com/eqnedit.php?latex=t_{back}&space;=&space;\frac{t}{2}&space;\text{,&space;backtracking}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?t_{back}&space;=&space;\frac{t}{2}&space;\text{,&space;backtracking}" title="t_{back} = \frac{t}{2} \text{, backtracking}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=t_{inter}&space;=&space;\frac{g'(0))}{2(g(1)-g(0)-g'(0))}&space;\text{,&space;interpolacion&space;cuadrática}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?t_{inter}&space;=&space;\frac{g'(0))}{2(g(1)-g(0)-g'(0))}&space;\text{,&space;interpolacion&space;cuadrática}" title="t_{inter} = \frac{g'(0))}{2(g(1)-g(0)-g'(0))} \text{, interpolacion cuadrática}" /></a>

## Condiciones de selección

Escogemos uno de los valores conforme a los criterios:

1 Si únicamente uno de los valores satisface la primer condición de Wolfe, se considera ese valor.

2 Si ambos valores satisfacen la condición de Wolfe se considera el mayor de ellos.

3 El paso elegido satisface la norma euclidiana de P y t es mayor a 0.001

4 El número de pasos de búsqueda sobre p no es mayor a 20

5 Si se exceden los 20 pasos o se cumple el paso 3, considerar t como 0.01

## Estructura del código

Se debe programar el método de búsqueda de línea con las siguientes consideraciones:

function [x, iter] = metodoblhibrido(fname, x0)

Método de búsqueda de línea con búsqueda de línea híbrida.

% Tolerancia para la norma del gradiente de f(x) es 1.e − 08.

% Número máximo de iteraciones externas maxiter = 250

% valor para la primer condición de Wolfe c1 = 1.e − 04.

% La dirección de descenso es

% (a) máximo descenso

% (b) dirección de Newton.

% Se resuelve sistemas lineales con matrices simétricas definidas positivas,

% debe usar la factorización de Cholesky.

## Funciones de prueba

| Función    | Punto inicial | Dirección       |
| ---------- | ------------- | ----------------|
| Rosenbrock | (2,2)         | Newton          |
| Rastrigin  | (0.4,0.3)     | Máximo descenso |
| Griewangk  | (2,0)         | Newton          |
| Ackley     | (0,1.5)       | Máximo descenso |
| Branin     | (-4,13)       | Newton          |
| Easom      | (5,5)         | Máximo descenso |
| McCormick  | (-0.5,-1.5)   | Ambas           |
| Perm       | (1,0.5)       | Ambas           |
