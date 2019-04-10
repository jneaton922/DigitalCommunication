function [bits] = adc_2_bit(qam_value,thresholds,bit_values)
    if qam_value < thresholds(1)
        bits = [bit_values(2),bit_values(1)];
    elseif qam_value < thresholds(2)
        bits = [bit_values(2),bit_values(2)];
    elseif qam_value < thresholds(3)
        bits = [bit_values(1),bit_values(2)];
    else
        bits = [bit_values(1),bit_values(1)];
    end
end