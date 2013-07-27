#!/usr/bin/env ruby

require 'dalli'
require 'statsd'
require 'resolv'
require './lib/active_users'

users= ActiveUsers.new(Dalli::Client.new)

puts "Number of active users before cleanup: #{users.count}"
new_count= users.cleanup
puts "Number of active users after cleanup: #{new_count}"
Statsd.new(Resolv.getaddress('statsd.lastmeme.com'), 8125).gauge 'users', new_count

