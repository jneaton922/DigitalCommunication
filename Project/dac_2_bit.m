function [a_out] = dac_2_bit(bits,bit_values,levels)
        if bits(1)==bit_values(1)
            if bits(2) == bit_values(1)
                a_out = levels(4);
            else
                a_out = levels(3);
            end
        else
            if bits(2) == bit_values(1)
                a_out = levels(1);
            else
                a_out = levels(2);
            end
        end
end