require_relative '3'



def english_count(message,dic)
    matches = 0
    possible_words = []
    message.split.each do |m|
        possible_words = []
        str = get_visible_str(m)
        str = str.upcase
        possible_words = str.split
        return 0.0 if possible_words.empty?

        possible_words.each do |possible_word|
            matches += 1 if dic.has_key?(possible_word)
        end
    end
    matches / possible_words.size.to_f
end


def get_visible_str(message)
    message.scan(/[[:print:]]/).join
end


def load_dictionary
 dic = {}
 File.open('dictionary.txt').each_line { |r| dic[r.strip]= 0 }
 dic
end

if __FILE__ == $0
    dic = {}

    dic = load_dictionary

    File.open('4.txt').each_line do |k|
        str = k.split.pack('H*')
        0.upto(127).each do |letter|
            expanded_string = letter.chr*str.length
            xored_string = xor_strings(str,expanded_string)
            count = english_count(xored_string,dic)
            puts "#{xored_string.strip} - #{letter}" if count > 4.0 #arbitrary number
        end
    end
end
