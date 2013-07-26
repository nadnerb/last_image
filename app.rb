require 'rubygems'
require 'sinatra'
require 'dalli'
require 'statsd'
require 'resolv'
require 'rack/session/dalli'

set :cache, Dalli::Client.new
set :session_store, Dalli::Client.new(nil, :namespace => 'users', :expire_after =>1200)
use Rack::Session::Dalli, :cache => settings.session_store

set :statsd, Statsd.new(Resolv.getaddress('statsd.lastmeme.com'), 8125)
set :images, ['http://i.qkme.me/3pk0sc.jpg', 'http://t.qkme.me/3v6soz.jpg', 'http://t.qkme.me/3v8twz.jpg', 'http://t.qkme.me/3ops.jpg']

after do
  settings.statsd.gauge 'users', settings.session_store.stats['curr_items']
end

get '/' do
  settings.statsd.increment 'image'
  @image = settings.images.sample
  erb :index
end

