#!/usr/bin/env ruby

require 'dalli'

cache= Dalli::Client.new

active_users = cache.get 'active_users'

exit unless active_users

puts "Number of active users before cleanup: #{active_users.size}"

active_users.delete_if { |key, time| time < Time.now - 180 }
cache.set('active_users', active_users)

puts "Number of active users after cleanup: #{active_users.size}"

