require 'rubygems'
require 'sinatra'
require 'dalli'

set :images, Dalli::Client.new(nil, :namespace => "images")

get '/' do
  erb :index
end

post '/submit' do
  settings.images.set(params['image']['name'], params['image']['url'])
end

get '/images' do
  @image = settings.images.get('bob')
  erb :images
end
