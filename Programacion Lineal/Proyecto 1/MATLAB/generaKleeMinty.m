function [A,b,c] = generaKleeMinty(m)

c = -ones(m, 1);
b = 2.^(1:m)' - 1; 
A = 2*tril(ones(m, m), -1) + eye(m);

end