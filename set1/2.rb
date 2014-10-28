
def fixed_xor(str1,str2)
    return false if str1.size != str2.size
    xor_str = str1.hex ^ str2.hex
    xor_str.to_s(16)
end


if __FILE__ == $0
    puts fixed_xor("1c0111001f010100061a024b53535009181c", "686974207468652062756c6c277320657965") == "746865206b696420646f6e277420706c6179"
end
