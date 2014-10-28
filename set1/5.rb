require_relative '2'

PT = "Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal".unpack('H*').join



KEY = %w[I C E].join.unpack("H2H2H2")

puts PT.scan(/../).map.with_index { |a, i| fixed_xor(a, KEY[i.modulo(3)]) }.join
