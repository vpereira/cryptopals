# trying brute force
require 'base64'
require_relative '2'
require_relative '4'



some_keys = []

module VigenereCipher
 
  BASE = 'A'.ord
  SIZE = 'Z'.ord - BASE + 1
 
  def encrypt(text, key)
    crypt(text, key, :+)
  end
 
  def decrypt(text, key)
    crypt(text, key, :-)
  end
 
  def crypt(text, key, dir)
    text = text.upcase.gsub(/[^A-Z]/, '')
    key_iterator = key.upcase.gsub(/[^A-Z]/, '').chars.map{|c| c.ord - BASE}.cycle
    text.each_char.inject('') do |ciphertext, char|
      offset = key_iterator.next
      ciphertext << ((char.ord - BASE).send(dir, offset) % SIZE + BASE).chr
    end
  end
 
end


def open_read_file
    f = File.read('6.txt');
    return f.unpack('m').join;
end

def get_random_string(n = 4)
    Array.new(n){[*'0'..'9', *'A'..'Z'].sample}.join
end

def get_random_numeric_key(n = 4)
    Array.new(n){[*'0'..'9', *'A'..'Z'].sample}.join
end

def get_random_string_up(n = 4)
    Array.new(n){[*'A'..'Z'].sample}.join
end


28.upto(30).each do |i|
    500_000.times.each do 
        some_keys << get_random_string_up(i)
    end
end


include VigenereCipher

ciphertext = open_read_file
dic = load_dictionary

some_keys = some_keys + dic.keys.select {|k| k.length >= 28 && k.length <= 30 }
some_keys.sort!
some_keys.each do |key|
    recovered = VigenereCipher.decrypt(ciphertext, key)
    puts key if recovered[0..5].match(/termin/i)
end
