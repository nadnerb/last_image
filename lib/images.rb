require './lib/image'

class Images

  def initialize
    @images = {}
    populate
  end

  def random
    @images.values.sample
  end

  def [] id
    @images[id]
  end

  def each &block
    @images.values.each &block
  end

  private
  def populate
    [
      {:name => 'dry clean only', :url => 'http://i.qkme.me/3rbofl.jpg'},
      {:name => 'waldo',          :url => 'http://t.qkme.me/3v8twz.jpg'},
      {:name => 'shaving',        :url => 'http://t.qkme.me/3ops.jpg'},
      {:name => 'liar',           :url => 'http://i.qkme.me/3qqutc.jpg'},
      {:name => 'northface',      :url => 'http://media2.policymic.com/a99dd6b0533046d442ef72c2c55ae755.jpg'},
      {:name => 'meow',           :url => 'http://media2.policymic.com/af9daec128ff5f479ee6e6031fec40a4.jpg'},
      {:name => 'horrible',       :url => 'http://media2.policymic.com/842c85f608b4795d6f079a16e9a3c109.jpeg'},
      {:name => 'stun',           :url => 'https://pbs.twimg.com/media/BPymrAQCIAQ_Pvp.jpg'}
    ].inject(1) do |id, image|
      cache(Image.new({:id => id}.merge(image)))
      id += 1
    end
  end

  def cache(image)
    @images[image.id.to_s] = image
  end

end
