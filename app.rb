require 'rubygems'
require 'sinatra'
require 'dalli'
require 'statsd'
require 'resolv'

enable :sessions
set :session_secret, 'last'
set :session_store, Dalli::Client.new(nil, :expire_in =>1200)

set :statsd, Statsd.new(Resolv.getaddress('statsd.lastmeme.com'), 8125)
set :images, ['http://i.qkme.me/3pk0sc.jpg', 'http://t.qkme.me/3v6soz.jpg', 'http://t.qkme.me/3v8twz.jpg', 'http://t.qkme.me/3ops.jpg']

after do
  settings.statsd.gauge 'users', settings.session_store.stats.values[0]['curr_items']
end

get '/' do
  settings.statsd.increment 'image'
  @image = settings.images.sample
  settings.session_store.add(session['session_id'], @image)
  erb :index
end

