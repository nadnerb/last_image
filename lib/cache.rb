require 'dalli'
module Cache
  extend self

  def users
    @users ||= Dalli::Client.new(nil, :namespace => 'users', :expire_in =>180)
  end

  def client name
    Dalli::Client.new(nil, :namespace => name)
  end

end

