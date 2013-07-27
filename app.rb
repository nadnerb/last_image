require 'rubygems'
require 'sinatra'
require 'dalli'
require 'statsd'
require 'resolv'
require './lib/active_users'

enable :sessions
set :session_secret, 'last'
set :cache, Dalli::Client.new(nil, :expire_in =>180)

set :statsd, Statsd.new(Resolv.getaddress('statsd.lastmeme.com'), 8125)
set :images, ['http://i.qkme.me/3pk0sc.jpg', 'http://t.qkme.me/3v6soz.jpg', 'http://t.qkme.me/3v8twz.jpg', 'http://t.qkme.me/3ops.jpg']
set :active_users, ActiveUsers.new(settings.cache)

after do
  count= settings.active_users.add(session['session_id'])
  settings.statsd.gauge 'users', count
end

get '/' do
  settings.statsd.increment 'image'
  settings.statsd.gauge('views', settings.cache.incr(session['session_id'] + '-image', 1, nil, 1))
  @image = settings.images.sample
  settings.cache.add(session['session_id'], @image)
  erb :index
end

