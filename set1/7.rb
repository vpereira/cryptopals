require 'openssl'
require 'base64'


cipher = OpenSSL::Cipher.new('AES-128-ECB')
cipher.decrypt 
cipher.key = "YELLOW SUBMARINE"
blob = File.open("7.txt", 'rb') {|io| io.read}
ciphertext = Base64.decode64(blob) 

decr = cipher.update(ciphertext)
decr << cipher.final
puts decr
