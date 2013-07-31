#!/usr/bin/env ruby

require 'librato/metrics'
Librato::Metrics.authenticate ENV['LIBRATO_EMAIL'], ENV['LIBRATO_KEY']
Librato::Metrics.annotate :deployments,  "Build #{ENV['BUILD_NUMBER']}",
  :start_time => ARGV[0],
  :end_time => ARGV[1]
