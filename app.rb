require 'sinatra'
require './lib/user'
require './lib/feature'
require './lib/images'

before do
  @user = User.new(session['session_id'])
end

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  set :session_secret, 'last'
  set :images, Images.new
  enable :sessions
end

get '/' do
  @image = settings.images.random
  @user.viewing(@image.url)
  erb :index
end

post '/funny' do
  settings.images[params[:image][:id]].funny!
  redirect '/'
end

post '/stupid' do
  settings.images[params[:image][:id]].stupid!
  redirect '/'
end

get '/votes' do
  erb :votes
end
