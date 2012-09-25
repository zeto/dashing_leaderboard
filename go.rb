require 'sinatra'
require 'redis'

require './bookie'

configure do
  Bookie.are_you_redis?
end

get '/' do
  @gamblers = Bookie.gamblers
  erb :index
end

post '/bet' do
  if params[:amount_at_risk] && params[:balance] && params[:name]
      Bookie.bet(params[:name], params[:balance].to_i, params[:amount_at_risk].to_i)
  end
  redirect '/'
end