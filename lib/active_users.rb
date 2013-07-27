
class ActiveUsers

  KEY= 'active_users'

  def initialize cache
    @cache= cache
  end

  def add sid
    active_users do |users|
      users[sid] = Time.now
    end.size
  end

  def count
    active_users.size
  end

  def cleanup
    active_users do |users|
      users.delete_if { |key, time| time < Time.now - 180 }
    end.size
  end


  private
  def active_users
    value= @cache.get(KEY) || {}
    if block_given?
      yield value
      @cache.set(KEY, value)
    end
    value
  end

end
