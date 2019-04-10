function [i,q] = bits_to_levels(bits,levels,bit_values)
    % considering levels in ascending order -> -1/rt2 --> 1/rt2
    % bit values also in ascending order, values(1) -> 0, values(2) -> 1
    
    % symbol mapping for b3.b2.b1.b0
    %  0010     0011        0001        0000
    %
    %  0110     0111        0101        0100
    %
    %  1110     1111        1101        1100
    %
    %  1010     1011        1001        1000
    
    i = zeros(1,length(bits)/4);
    q = zeros(1,length(bits)/4);
    for ind=0:(length(bits)/4 -1)
        q_bits = [bits(4*ind + 1),bits(4*ind + 2) ];
        i_bits = [bits(4*ind + 3),bits(4*ind + 4) ];
        q(1,ind+1) = dac_2_bit(q_bits,bit_values,levels);
        i(1,ind+1) = dac_2_bit(i_bits,bit_values,levels);
    end
end
