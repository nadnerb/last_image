require 'sinatra'
require './lib/user'
require './lib/feature'
require './lib/memes'

before do
  @user = User.new(session['session_id'])
end

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  set :session_secret, 'last'
  set :memes, Memes.new
  set :feature, Feature.new
  enable :sessions
end

get '/' do
  @meme = settings.memes.random
  @user.viewing(@meme.url)
  erb :index
end

post '/funny' do
  settings.memes[params[:meme][:id]].funny!
  redirect '/'
end

post '/stupid' do
  settings.memes[params[:meme][:id]].stupid!
  redirect '/'
end

get '/votes' do
  erb :votes
end

get '/activate_feature' do
  settings.feature.activate(:voting)
  redirect '/'
end

get '/deactivate_feature' do
  settings.feature.deactivate(:voting)
  redirect '/'
end
