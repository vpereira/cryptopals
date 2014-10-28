def xor_strings(str1,str2)
    str1 = str1.unpack('C*')
    str2 = str2.unpack('C*')
    case 
    when str1.size > str2.size
        str2 = [0] * (str1.size - str2.size) + str2
    when str2.size > str1.size
        str1 = [0] * (str2.size - str1.size) + str1
    end
    str1.zip(str2).map{ |a,b| a^b }.pack("U*")
end

def get_score(str)
    total = 0
    # all printable chars
    printable_ascii_values = 32.upto(126).to_a 
    str.bytes.each do |c|
        total+= 1 if printable_ascii_values.include?(c)
    end
    total / str.size
end
if __FILE__ == $0
    0.upto(127).each do |letter|
        # Cooking MC's like a pound of bacon
        input_string = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736".split.pack('H*')
        expanded_string = letter.chr*input_string.length
        xored_string = xor_strings(input_string,expanded_string)
        score = get_score(xored_string)
        puts xored_string if score == 1
    end
end
