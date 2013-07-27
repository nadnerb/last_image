#!/usr/bin/env ruby

require 'dalli'
require './lib/active_users'

users= ActiveUsers.new(Dalli::Client.new)

puts "Number of active users before cleanup: #{users.count}"
new_count= users.cleanup
puts "Number of active users after cleanup: #{new_count}"

