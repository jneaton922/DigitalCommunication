function data = sample_signal(signal,gamma,num_bits,spb,k,data_values)
    data = data_values(2)*ones(1,num_bits);
    for i = 0:num_bits-1
        if signal(k*spb+(spb*i)) < gamma
            data(i+1) = data_values(1);
        end
    end
end