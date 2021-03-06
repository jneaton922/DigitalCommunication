function [bits] = de_hamming_7_4(encoded_data,values)
    bits = zeros(1,length(encoded_data)*4/7);
    d_ind = 1;
    for ind = 1:7:length(encoded_data)
       block =  encoded_data(ind:ind+6);
       i = block(1:4);
       p = block(5:end);
       
       % encoded 123, 234, 124
       % if all of these three are zero, no error
       % otherwise determine which bit via overlap
       pc1 = mod(mod(mod((i(1)==values(2))+(i(2)==values(2)),2)+(i(3)==values(2)),2)+p(1),2);
       pc2 = mod(mod(mod((i(1)==values(2))+(i(3)==values(2)),2)+(i(4)==values(2)),2)+p(2),2);
       pc3 = mod(mod(mod((i(1)==values(2))+(i(2)==values(2)),2)+(i(4)==values(2)),2)+p(3),2);
       if pc1 
           if pc2
               if pc3
                   i(1) = values((i(1)==values(1))+1);
               else
                   i(3) = values((i(3)==values(1))+1);
               end
           else
               if pc3
                   i(2) = values((i(2)==values(1))+1);
               end
           end
       elseif pc2 && pc3
           i(4) = values((i(4)==values(1))+1);
       end 
       bits(d_ind:d_ind+3) = i;
       d_ind = d_ind+4;
    end
end