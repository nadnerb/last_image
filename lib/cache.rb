require 'dalli'
module Cache
  extend self

  def users
    @users ||= Dalli::Client.new(nil, :namespace => 'users', :expire_in =>180)
  end
end

