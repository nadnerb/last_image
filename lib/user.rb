require './lib/cache'
require './lib/metrics'

class User

  def initialize sid
    @sid = sid
    User.active_users do |users|
      users[sid] = Time.now
      Metrics.gauge 'users', users.size
    end
    unless Cache.users.get(sid)
      Cache.users.set(sid, '', nil, :raw => true)
    end
  end

  def self.count
    active_users.size
  end

  def self.cleanup
    active_users do |users|
      users.delete_if { |key, time| time < Time.now - 180 }
      Metrics.gauge 'users', users.size
    end.size
  end

  def viewed
    Cache.users.get(@sid)
  end

  def viewing image
    Cache.users.append(@sid, image + '||')
    Metrics.increment 'image'
    Metrics.gauge('views', Cache.users.incr(@sid + '-image', 1, nil, 1))
  end

  private
  def self.active_users
    value= Cache.users.get('active_users') || {}
    if block_given?
      yield value
      Cache.users.set('active_users', value)
    end
    value
  end

end
