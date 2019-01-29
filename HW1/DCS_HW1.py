import csv

encode_dict = {
    '2':'00000',
    '3':'1000',
    '4':'0001',
    '5':'110',
    '6':'001',
    '7':'010',
    '8':'011',
    '9':'111',
    '10':'101',
    '11':'1001',
    '12':'00001'
}
data = []
ord_bits = ''
enc_bits = ''

# read in input data
with open('HW1_rolls.csv') as file:
    reader = csv.reader(file, delimiter=',')
    line_count = 0
    for row in reader:
        data+=row
file.close()

for d in data:
        # pad to 4 bits per message
        ord_bits += bin(int(d))[2:].zfill(4)
        enc_bits += encode_dict[d]

print("Ordinary Binary Data:")
print(ord_bits)
print(len(ord_bits))
with open('ordinary_bit_string.txt','w') as f:
    f.write(ord_bits)
f.close()

print("Encoded Data:")
print(enc_bits)
print(len(enc_bits))
with open('encoded_bit_string.txt','w') as f:
    f.write(enc_bits)
f.close()


        
        
            
