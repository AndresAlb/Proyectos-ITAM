function [a] = recortarPaso(y, u, dy, du)

% recortarPaso Calcula el valor mínimo de a tal que 
%       
%       y + a*dy > 0       y       z + a*dz > 0
% 
% IN:       y ... vector columna de m x 1
%           z ... vector columna de m x 1
%          dy ... vector columna de m x 1
%          dz ... vector columna de m x 1
%
% OUT:      a ... número real 

    m = length(y);
    a1 = ones(m, 1);
    a2 = ones(m, 1);
    
    negativos = dy < 0;
    a1(negativos) = -y(negativos)./dy(negativos);
    
    negativos = du < 0;
    a2(negativos) = -u(negativos)./du(negativos);
    
    if(isempty(a1) && isempty(a2))
        a = 0.995;
    elseif(isempty(a1))
        a = 0.995*min([1; a2]);
    elseif(isempty(a2))
        a = 0.995*min([1; a1]);
    else
        a = 0.995*min([1; a1; a2]);
    end

end