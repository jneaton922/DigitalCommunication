function [values] = bits(n,an)
    values = an(round(rand(1,n))+1);
end