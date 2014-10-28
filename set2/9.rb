BLOCKSIZE = 20

our_str = "YELLOW SUBMARINE"

# for sake of example, our_str is smaller than blocksize

pad = BLOCKSIZE - our_str.size

puts "#{our_str}#{pad.chr*pad}".force_encoding('ascii-8bit').inspect

