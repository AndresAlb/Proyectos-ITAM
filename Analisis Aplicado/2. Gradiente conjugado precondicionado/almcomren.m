function [AA,ind] = almcomren(A)
% Función que guarda una matrix rala por almacenamiento comprimido
% por renglones.
% 
% el vector de índices ind contiene el número de las columnas de AA que
% son ceros.
% Mauricio Trejo Santamaria 138886
% Andrés Albores Ángeles 131749

[m,n] = size(A);
AA = [];
ind = [];
k = 0;

for i=1:m
    for j=1:n
        if A(i,j) ~= 0
            AA = [AA [A(i,j) j]'];
            k = k + 1;
        end
    end
    AA = [AA [0 0]'];
    k = k + 1;
    ind = [ind k];
end

end

