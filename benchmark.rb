require 'benchmark'
require './bookie'

def random_word()
  chars = 'abcdefghjkmnpqrstuvwxyz'
  word = ''
  4.times { |i| word << chars[rand(chars.length)] }
  word
end

if __FILE__ == $PROGRAM_NAME
  Bookie.are_you_redis?

  a = Benchmark.measure do
    5000.times do
      Bookie.bet(random_word, rand(1000), rand(1000))
    end
  end

  puts a
end

