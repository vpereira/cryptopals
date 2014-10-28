ciphertexts = []
File.open('8.txt').each_line do |line|
    ciphertexts <<  [line.strip].pack('H*').force_encoding("ascii-8bit") 
end

blocks = {}
ciphertexts.each do |ciphertext|
    unpacked_ciphertext =  ciphertext.unpack("H2" * ciphertext.size)
    unpacked_ciphertext.each_slice(16) do |slice|
        if blocks.has_key?(slice.join)
            blocks[slice.join] += 1
        else
            blocks[slice.join] = 1
        end
    end
end

blocks.each do |k,v|
    puts "#{k} - #{v}" if v > 1
end
