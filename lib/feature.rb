require 'rollout'
require 'delegate'
require './lib/cache'

class Feature < SimpleDelegator

  attr_reader :rollout

  def initialize
    super Rollout.new(cache)
  end

  private
  def cache
    Cache.client('feature')
  end
end
