require 'sinatra'
require 'redis'

configure do
  $redis = Redis.new(:host => 'localhost', :port => 6379)
  raise 'Cant connect to Redis' unless $redis
end

get '/' do
  @gamblers = $redis.zrevrange("gamblers", 0, -1, :with_scores => 1)
  erb :index
end

post '/bet' do
  if params[:amount_at_risk] && params[:balance] && params[:name]
      bet(params[:name], params[:balance], params[:amount_at_risk])
  end
  redirect '/'
end

def bet(name, balance, amount_at_risk)
  $redis.zadd('gamblers', params[:amount_at_risk].to_i + params[:balance].to_i, params[:name])
end