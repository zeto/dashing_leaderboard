require 'redis'

module Bookie

  def self.are_you_redis?
    @@redis = Redis.new(:host => 'localhost', :port => 6379)
    raise 'Cant connect to Redis' unless @@redis
  end

  def self.bet(name, balance, amount_at_risk)
    @@redis.zadd('gamblers', amount_at_risk + balance, name)
  end

  def self.gamblers
    @@redis.zrevrange("gamblers", 0, -1, :with_scores => 1)
  end
end