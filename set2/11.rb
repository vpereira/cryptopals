require 'openssl'

BLOCKSIZE = 16

def random_key(n = BLOCKSIZE)
    Array.new(n){[*'0'..'9', *'A'..'Z',*'a'..'z'].sample}.join
end


def detect_ecb(ciphertext)
    blocks = {}
    unpacked_ciphertext =  ciphertext.unpack("H2" * ciphertext.size)
    unpacked_ciphertext.each_slice(BLOCKSIZE) do |slice|
        if blocks.has_key?(slice.join)
            blocks[slice.join] += 1
        else
            blocks[slice.join] = 1
        end
    end
    blocks.values.any? {|e| e > 1 }
end

def encryption_oracle(message)
    return "" if message.length % BLOCKSIZE  != 0
    padded_plain_text = "#{'b'*rand(5..10)}#{message}#{'d'*rand(5..10)}"

    cipher = case rand(0..1)
    when 0
        OpenSSL::Cipher.new('AES-128-ECB')
    when 1
        OpenSSL::Cipher.new('AES-128-CBC')
    end
    cipher.encrypt
    cipher.key = random_key
    cipher.random_iv
    enc = cipher.update(padded_plain_text) + cipher.final
    #Hex encoded
    enc.unpack('H*').join
end

enc = encryption_oracle("FOOBAR IS COOL!!" * 16)

puts enc
puts "ECB? " + detect_ecb([enc].pack('H*')).to_s
