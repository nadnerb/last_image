require 'rubygems'
require 'sinatra'
require 'dalli'
require 'statsd'
require 'resolv'
require './lib/user'

enable :sessions
set :session_secret, 'last'

set :images, ['http://i.qkme.me/3pk0sc.jpg', 'http://t.qkme.me/3v6soz.jpg', 'http://t.qkme.me/3v8twz.jpg', 'http://t.qkme.me/3ops.jpg']

before do
  @user = User.new(session['session_id'])
end

get '/' do
  @image = settings.images.sample
  @user.viewing(@image)
  erb :index
end

