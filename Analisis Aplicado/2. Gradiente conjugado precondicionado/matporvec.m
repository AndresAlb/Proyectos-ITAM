function [v] = matporvec(AA,ind,x)
% Funci�n que realiza el producto matriz por vector v = A*x donde
% A se guarda en AA seg�n la funci�n almcomren.m
% Mauricio Trejo Santamaria 138886
% Andr�s Albores �ngeles 131749

n = length(ind);
v = zeros(n,1);
for i=1:n
    if i == 1
        for j=1:ind(i)-1
            v(i) = v(i) + AA(1,j)*x(AA(2,j));
        end
    else
        for j=ind(i-1)+1:ind(i)-1
            v(i) = v(i) + AA(1,j)*x(AA(2,j));
        end
    end
end

end

