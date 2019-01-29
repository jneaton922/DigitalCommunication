with open('encoded_bit_string.txt','r') as f:
        data = f.read()
f.close()


orig_msg = []
while not data == "":
    if data[0] == '0':
        if data[1] == '0':
            if len(data) > 2 and data[2] == '0':
                if len(data) > 3 and data[3] == '0':
                    if data[4] == '0':
                        orig_msg.append(2)
                        data = data[5:]
                    else:
                        orig_msg.append(12)
                        data = data[5:]
                else:
                    orig_msg.append(4)
                    data = data[4:]
            else:
                orig_msg.append(6)
                data = data[3:]
        else:
            if len(data) >2 and data[2] == '1':
                orig_msg.append(8)
                data = data[3:]
            else:
                orig_msg.append(7)
                data = data[3:]
    else:
        if data[1] == '1':
            if len(data) > 2 and data[2] == '1':
                orig_msg.append(9)
                data = data[3:]
            else:
                orig_msg.append(5)
                data = data[3:]
        else:
            if len(data) >2 and data[2] == '1':
                orig_msg.append(10)
                data = data[3:]
            else:
                if len(data) > 4 and data[4] == '0':
                    orig_msg.append(3)
                    data = data[4:]
                else:
                    orig_msg.append(11)
                    data = data[4:]


print(orig_msg)


                
    
