function [AA,ind] = almcomren(A)
% Funci�n que guarda una matrix rala por almacenamiento comprimido
% por renglones.
% 
% el vector de �ndices ind contiene el n�mero de las columnas de AA que
% son ceros.
% Mauricio Trejo Santamaria 138886
% Andr�s Albores �ngeles 131749

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

