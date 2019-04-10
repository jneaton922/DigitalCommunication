function [encoded_data] = hamming_7_4(bits,values)
    if mod(length(bits),4 ~= 0)
        bits = [bits,values(1)*ones(1,4-mod(length(bits),4))];
    end
    encoded_data = zeros(1,1.75*length(bits));
    enc_ind = 1;
    for ind = 1:4:length(bits)
        i = bits(ind:ind+3);
        p1 = values(mod(mod((i(1)==values(2))+(i(2)==values(2)),2)+(i(3)==values(2)),2)+1);
        p2 = values(mod(mod((i(1)==values(2))+(i(3)==values(2)),2)+(i(4)==values(2)),2)+1);
        p3 = values(mod(mod((i(1)==values(2))+(i(2)==values(2)),2)+(i(4)==values(2)),2)+1);
        encoded_data(enc_ind:enc_ind+6) = [i p1 p2 p3];
        enc_ind = enc_ind + 7;
    end
end