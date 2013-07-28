#!/usr/bin/env ruby

require 'dalli'
require 'statsd'
require 'resolv'
require './lib/user'

puts "Number of active users before cleanup: #{User.count}"
new_count= User.cleanup
puts "Number of active users after cleanup: #{new_count}"

