
require 'statsd'
module Metrics
  extend self

  def increment counter
    statsd.increment counter
  end

  def gauge name, value
    statsd.gauge name, value
  end

  private
  def statsd
    @statd ||= Statsd.new(Resolv.getaddress('statsd.lastmeme.com'), 8125)
  end

end
