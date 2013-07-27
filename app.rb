require 'rubygems'
require 'sinatra'
require 'dalli'
require 'statsd'
require 'resolv'

enable :sessions
set :session_secret, 'last'
set :cache, Dalli::Client.new(nil, :expire_in =>180)

set :statsd, Statsd.new(Resolv.getaddress('statsd.lastmeme.com'), 8125)
set :images, ['http://i.qkme.me/3pk0sc.jpg', 'http://t.qkme.me/3v6soz.jpg', 'http://t.qkme.me/3v8twz.jpg', 'http://t.qkme.me/3ops.jpg']

after do
  active_users= settings.cache.get('active_users') || {}
  active_users[session['session_id']] = Time.now
  settings.cache.set('active_users', active_users)
  settings.statsd.gauge 'users', active_users.size
end

get '/' do
  settings.statsd.increment 'image'
  settings.statsd.gauge('views', settings.cache.incr(session['session_id'] + '-image', 1, nil, 1))
  @image = settings.images.sample
  settings.cache.add(session['session_id'], @image)
  erb :index
end

