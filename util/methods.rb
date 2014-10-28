# frequency taken from http://en.wikipedia.org/wiki/Letter_frequency
ENGLISH_LETTER_FREQ = {'E'=>12.70, 'T'=> 9.06, 'A'=> 8.17, 'O'=> 7.51, 'I'=> 6.97, 'N'=> 6.75, 'S'=> 6.33, 'H'=> 6.09, 'R'=> 5.99, 'D'=> 4.25, 'L'=> 4.03, 'C'=> 2.78, 'U'=> 2.76, 'M'=> 2.41, 'W'=>2.36, 'F'=> 2.23, 'G'=> 2.02, 'Y'=> 1.97, 'P'=> 1.93, 'B'=> 1.29, 'V'=> 0.98, 'K'=> 0.77, 'J'=> 0.15, 'X'=> 0.15, 'Q'=> 0.10, 'Z'=> 0.07}

ETAOIN = %w[E T A O I N S H R D L C U M W F G Y P B V K J X Q Z]

LETTERS = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]

def get_letter_count(message)
  # Returns a hash with keys of single letters and values of the
  # count of how many times they appear in the message parameter.
  letter_count = LETTERS.collect { |l| [l,0] }.to_h

  message.upcase.each_char do |c|
    letter_count[c] += 1 if LETTERS.include?(c)
  end

  letter_count.to_h
end

def frequency_order(message)
     # Returns a string of the alphabet letters arranged in order of most
     # frequently occurring in the message parameter.

     # first, get a hash  of each letter and its frequency count
     letter_to_freq = get_letter_count(message)
    
     # sort it by value reverse
     letter_to_freq_sorted = letter_to_freq.sort_by { |k,v| -v }.to_h
     # get the keys and join it forming something like "ETAOL...."
     letter_to_freq_sorted.keys.join
end

def english_freq_match_score(message)
     # Return the number of matches that the string in the message
     # parameter has when its letter frequency is compared to English
     # letter frequency. A "match" is how many of its six most frequent
     # and six least frequent letters is among the six most frequent and
     # six least frequent letters for English.
     freq_order = frequency_order(message)
     match_score = 0
     # Find how many matches for the six most common letters there are.
     ETAOIN.first(6).each do |common_letter|
        match_score+= 1 if freq_order.include?(common_letter)
     end
     # Find how many matches for the six least common letters there are.
     ETAOIN.last(6).each do |uncommon_letter|
       match_score+= 1 if freq_order.include?(uncommon_letter)
     end
    match_score
end

if __FILE__ == $0
    m1 = "Sy l nlx sr pyyacao l ylwj eiswi upar lulsxrj isr sxrjsxwjr, ia esmm rwctjsxsza sj wmpramh, lxo txmarr jia aqsoaxwa sr pqaceiamnsxu, ia esmm caytra jp famsaqa sj. Sy, px jia pjiac ilxo, ia sr pyyacao rpnajisxu eiswi lyypcor l calrpx ypc lwjsxu sx lwwpcolxwa jp isr sxrjsxwjr, ia esmm lwwabj sj aqax px jia rmsuijarj aqsoaxwa. Jia pcsusx py nhjir sr agbmlsxao sx jisr elh. -Facjclxo Ctrramm".force_encoding('ascii-8bit')
    puts frequency_order(m1)
    puts english_freq_match_score(m1)

    m2 = "I rc ascwuiluhnviwuetnh,osgaa ice tipeeeee slnatsfietgi tittynecenisl. e fo f fnc isltn sn o a yrs sd onisli ,l erglei trhfmwfrogotn,l  stcofiit.aea  wesn,lnc ee w,l eIh eeehoer ros  iol er snh nl oahsts  ilasvih  tvfeh rtira id thatnie.im ei-dlmf i  thszonsisehroe, aiehcdsanahiec  gv gyedsB affcahiecesd d lee   onsdihsoc nin cethiTitx  eRneahgin r e teom fbiotd  n  ntacscwevhtdhnhpiwru".force_encoding('ascii-8bit')
    puts frequency_order(m2)
    puts english_freq_match_score(m2)
end
