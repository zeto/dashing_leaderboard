require 'benchmark'
require './bookie'

def random_word()
  chars = 'abcdefghjkmnpqrstuvwxyz'
  word = ''
  4.times { |i| word << chars[rand(chars.length)] }
  word
end

Bookie.are_you_redis?

what_a_fast_bookie = Benchmark.measure do
  5000.times do
    Bookie.bet(random_word, rand(1000), rand(1000))
  end
end

puts what_a_fast_bookie

