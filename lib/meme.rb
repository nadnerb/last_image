require './lib/vote'

class Meme
  attr_reader :id, :name, :url

  def initialize args
    @id   = args[:id]
    @name = args[:name]
    @url  = args[:url]
  end

  def funny!
    Vote.increment('funny', id)
  end

  def stupid!
    Vote.increment('stupid', id)
  end

  def funny_count
    Vote.get('funny', id)
  end

  def stupid_count
    Vote.get('stupid', id)
  end

  def total
    funny_count.to_i - stupid_count.to_i
  end

  def <=>(other)
    other.total <=> total
  end

end
