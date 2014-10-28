require_relative '4'
require_relative '../util/methods'

def open_read_file
    f = File.read('6.txt')
    f.unpack('m').join
end


def hamming_distance(a,b)
    return 0 if a.length != b.length
    # make it binary 
    a_bin = a.unpack('b*').join
    b_bin = b.unpack('b*').join
    diff = []
    a_bin.each_char.with_index { |ch,i| diff << (ch.hex^b_bin[i].hex) }
    diff.join.count("1")
 end

def test_keysize(f, size)
    a = f[0..(size-1)]
    b = f[size..(size*2)-1]
    hamming_distance(a,b)
end


def find_lowest_key(data)
    hamming_values = {}
    2.upto(40).each do |n| #KEYSIZE to be guessed: from 2 to 40
        hamming = 0
        b = data.length/n #Number of blocks
        (0..b-2).each do |k| #Process hamming for every block and average it
            hamming += test_keysize(data[n*k..data.length], n)
        end
        hamming = hamming.to_f/(n*b)
        hamming_values[n] = hamming
    end
    hamming_values.sort_by {|k,v| v}.first[0]
end

def get_block_from_file(f, size)
    ret = []
    i = 0
    until i >=f.length do
        ret.push(f[i])
        i += size
    end
    return ret.join
end

def xor_thekey(enc_string, i)
    #Then xor's that string by a single character
    ret = []
    enc_string.each_byte { |b| ret.push((b ^ i).chr) }
    return ret.join
end

def key_search(enc_string)
    #For a given string, searches through each single byte character for
    #a feasible decoding using the ETAOIN SHRDLU frequency
    (0..255).each do |x|
        evaluated = xor_thekey(enc_string, x)
        magiccount = evaluated.scan(/[ETAOIN SHRDLU]/i).size
        evaluated = evaluated.gsub(/[\r\t\n]/, "") #Removing control characters protects us during debugging
        evaluated = evaluated.gsub(/[[:cntrl:]]/,"")
        if magiccount > 65
            puts "Potential match at #{x.chr} counting #{magiccount} "
        end
    end
end

def search_blocks_for_key(keysize,data)
    (0..keysize-1).each do |b|
        puts "Byte #{b}"
        block = get_block_from_file(data[b, data.length], keysize)
        key_search(block)
    end
end

data = open_read_file
puts data.force_encoding('ascii-8bit').inspect
keysize = find_lowest_key(data)
puts "keysize: #{keysize}"
search_blocks_for_key(keysize,data)
