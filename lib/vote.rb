require './lib/cache'
require './lib/metrics'

module Vote
  extend self

  def get(type, id)
    votes.get(key(type, id))
  end

  def increment(type, id)
    votes.incr(key(type, id), 1, nil, 1)
    Metrics.increment type
  end

  private
  def key(type, id)
    "#{type}.#{id}"
  end

  def votes
    @votes ||= Cache.client('votes')
  end
end
