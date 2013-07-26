require 'rubygems'
require 'sinatra'
require 'dalli'

set :cache, Dalli::Client.new
set :statsd, Statsd.new 'statsd.lastmeme.com', 9125

set :images, ['http://i.qkme.me/3pk0sc.jpg', 'http://t.qkme.me/3v6soz.jpg', 'http://t.qkme.me/3v8twz.jpg', 'http://t.qkme.me/3ops.jpg']

get '/' do
  settings.statsd.increment 'image'
  @image = settings.images.sample
  erb :index
end

