require 'sinatra'
require './lib/user'
require './lib/feature'

before do
  @user = User.new(session['session_id'])
end

set :images, [
  {:url => 'img/continuous.jpg'},
]

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
  set :session_secret, 'last'
  set :feature, Feature.new
end

get '/' do
  @image = settings.images.sample
  @user.viewing(@image[:url])
  erb :index
end
