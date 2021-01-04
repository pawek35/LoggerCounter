# frozen_string_literal: true

require_relative '../models/site'
require_relative '../models/display_visits_strategy'

module Services
  # A service which returns site names, sorted by the most visited ones.
  # Sorting  depends on strategy object injected to the instance
  class SiteLogParser
    attr_writer :display_strategy

    def initialize(display_strategy = nil)
      @display_strategy = display_strategy || Models::DisplayVisitsStrategy.new
    end

    def call(file_path)
      create_site_hash(file_path)
      return_results
    end

    def return_results
      @display_strategy.display(@site_collection)
    end

    private

    # Creates a Hash. Key is site_path and Value is Site model.
    def create_site_hash(file_path)
      @site_collection = {}
      File.readlines(file_path).each do |line|
        site_path, ip = line.split
        @site_collection[site_path] ||= Models::Site.new(site_path)
        @site_collection[site_path].visit(ip)
      end
      @site_collection = @site_collection.values
    end
  end
end
