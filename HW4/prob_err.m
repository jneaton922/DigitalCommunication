function Pe = prob_err(A,T,sigma2)
    Pe = 0.5.*(qfunc((A-T)./sqrt(sigma2)) + qfunc((A+T)./sqrt(sigma2)));
end