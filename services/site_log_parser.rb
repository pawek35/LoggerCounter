# frozen_string_literal: true

require_relative '../models/site'

module Services
  # A service which returns site names, sorted by the most visited ones
  class SiteLogParser
    attr_writer :sort_strategy
    attr_reader :result

    def initialize(sort_strategy)
      @sort_strategy = sort_strategy
      @site_collection = {}
      @result = []
    end

    def call(file_path)
      create_site_hash(file_path)
      @result = sites_visit_count
    end

    def sort
      sort_strategy(result)
    end

    private

    attr_reader :site_collection

    # Creates a Hash. Key is site_path and Value is Site model.
    def create_site_hash(file_path)
      File.readlines(file_path).each do |line|
        site_path, ip = line.split
        site_collection[site_path] ||= Models::Site.new(site_path)
        site_collection[site_path].visit(ip)
      end
    end

    # Returns an array with visit count per each site
    def sites_visit_count
      site_collection.values.map(&:visit_print)
    end
  end
end
