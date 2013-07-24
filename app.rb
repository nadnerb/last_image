require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/image'

get '/' do
  erb :index
end

post '/submit' do
  @model = Image.new(params[:image])
  if @model.save
    redirect '/images'
  else
    "Sorry, there was an error!"
  end
end

get '/images' do
  @images = Image.all
  erb :images
end
