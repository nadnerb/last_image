#!/usr/bin/env ruby

require 'librato/metrics'
Librato::Metrics.authenticate ENV['LIBRATO_EMAIL'], ENV['LIBRATO_KEY']
Librato::Metrics.annotate :deployments, "Build #{ENV['BUILD_NUMBER']}"
