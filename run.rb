# frozen_string_literal: true

require_relative 'services/site_log_parser'
require_relative 'models/display_uniq_visits_strategy'

log_parser = Services::SiteLogParser.new

puts '-------------------------------------------'
puts 'All site vists'
puts '-------------------------------------------'
puts log_parser.call('webserver.log')

puts '-------------------------------------------'
puts 'Unique site vists'
puts '-------------------------------------------'
log_parser.display_strategy = Models::DisplayUniqVisitsStrategy.new
puts log_parser.call('webserver.log')
