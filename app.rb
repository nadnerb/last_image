require 'sinatra'
require './lib/user'

before do
  @user = User.new(session['session_id'])
end

set :cache, Dalli::Client.new("localhost:11211", { :namespace => "lastmeme", :compress => true })

set :images, [
  {:id => 1, :url => 'http://i.qkme.me/3rbofl.jpg'},
  {:id => 2, :url => 'http://t.qkme.me/3v8twz.jpg'},
  {:id => 3, :url => 'http://t.qkme.me/3ops.jpg'},
  {:id => 4, :url => 'http://i.qkme.me/3qqutc.jpg'},
  {:id => 5, :url => 'http://media2.policymic.com/a99dd6b0533046d442ef72c2c55ae755.jpg'},
  {:id => 6, :url => 'http://media2.policymic.com/af9daec128ff5f479ee6e6031fec40a4.jpg'},
  {:id => 7, :url => 'http://media2.policymic.com/842c85f608b4795d6f079a16e9a3c109.jpeg'}
]

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
  set :session_secret, 'last'
end

get '/' do
  @image = settings.images.sample
  @user.viewing(@image[:url])
  erb :index
end

