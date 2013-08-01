require './lib/meme'

class Memes

  attr_reader :memes

  def initialize
    @memes = {}
    populate
  end

  def random
    memes.values.sample
  end

  def [] id
    memes[id]
  end

  def each &block
    memes.values.each &block
  end

  def sort
    memes.values.sort
  end

  private
  def populate
    [
      {:name => 'continuous',     :url => '/img/continuous.jpg'},
      {:name => 'dry clean only', :url => '/img/dryclean.jpg'},
      {:name => 'waldo\'s head',  :url => '/img/waldo.jpg'},
      {:name => 'bananas',        :url => '/img/bananas.jpg'},
      {:name => 'liar',           :url => '/img/liar.jpg'},
      {:name => 'northface',      :url => '/img/northface.jpg'},
      {:name => 'meow',           :url => '/img/meow.jpg'},
      {:name => 'horrible',       :url => '/img/horrible.jpg'},
      {:name => 'stun',           :url => '/img/stun.jpg'},
      {:name => 'beer cat',       :url => '/img/beercat.jpg'},
      {:name => 'seen',           :url => '/img/seen.jpg'},
      {:name => 'doctor',         :url => '/img/doctor.jpg'},
      {:name => 'puppy',          :url => '/img/puppy.jpg'},
      {:name => 'poop',           :url => '/img/poop.jpg'},
      {:name => 'it\'s working',  :url => '/img/working.jpg'},
      {:name => 'mercy',          :url => '/img/mercy.jpg'},
      {:name => 'interesting',    :url => '/img/interesting.jpg'},
      {:name => 'badtime',        :url => '/img/badtime.jpg'},
      {:name => 'notsure',        :url => '/img/notsure.jpg'},
      {:name => 'success',        :url => '/img/success.jpg'},
      {:name => 'steve',          :url => '/img/steve.jpg'}
    ].inject(1) do |id, meme_hash|
      cache(Meme.new({:id => id}.merge(meme_hash)))
      id += 1
    end
  end

  def cache(meme)
    memes[meme.id.to_s] = meme
  end

end
