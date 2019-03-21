function nt = noise(t,variance)
    nt = sqrt(variance).*randn(1,length(t));
end