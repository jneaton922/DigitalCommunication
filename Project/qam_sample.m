function [data] = qam_sample(xt,yt,spb,k,thresholds,bit_values)
    data = zeros(1,(length(xt)-2*k*spb)/spb*4);
    for ind=0:length(data)/4 - 1
        q_bits = adc_2_bit(yt(k*spb + ind*spb),thresholds,bit_values);
        i_bits = adc_2_bit(xt(k*spb + ind*spb),thresholds,bit_values);
        offs = 4*ind;
        data(offs+1:offs+2) = q_bits;
        data(offs+3:offs+4) = i_bits;
    end
        
end