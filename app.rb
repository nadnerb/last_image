require 'rubygems'
require 'sinatra'
require 'dalli'

set :cache, Dalli::Client.new

set :images, ['http://i.qkme.me/3pk0sc.jpg', 'http://t.qkme.me/3v6soz.jpg', 'http://t.qkme.me/3v8twz.jpg', 'http://t.qkme.me/3ops.jpg']

get '/' do
  @image = settings.images.sample
  erb :index
end

