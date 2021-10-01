function [C, Ceq] = g78(x)
% G78 Función de restricciones correspondiente al Ejemplo 7.8 de 
% Engineering Optimization de Singoresu Rao

Ceq = [];
C = [-x(1)^2 - x(2)^2 + x(3)^2; -4 + x(1)^2 + x(2)^2 + x(3)^2;...
    -x(3) + 5; x(1); x(2); x(3)];

end