require 'openssl'

BLOCKSIZE = 16 # 128 bits

# i assume both are same size
def block_xor(a,b)
    c = []
    a.each_char.with_index do |ch,i|
        c << (ch.ord ^ b[i].ord).chr
    end
    c.join
end

def decrypt_CBC(enc,cipher)
    nth_block = "0".chr * BLOCKSIZE # first = IV
    plaintext = []
    # get BLOCKSIZE chunck bytes
    (0..enc.length-BLOCKSIZE).step(BLOCKSIZE).each do |offset|
        block = enc[offset..offset+BLOCKSIZE-1]
        decrypted = cipher.update(block) + cipher.final
        #we have to xor decrypted with nth_block 
        plaintext << block_xor(decrypted,nth_block)
        nth_block = block # move it forward
    end
    plaintext.join
end

cipher = OpenSSL::Cipher.new('AES-128-ECB')
cipher.decrypt;
cipher.padding = 0; #we must force it, otherwise OpenSSL will pad it
cipher.key = "YELLOW SUBMARINE"
enc = File.read('10.txt')
enc = enc.unpack('m').join
puts decrypt_CBC(enc,cipher).inspect
