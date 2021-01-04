# frozen_string_literal: true

module Models
  # Class which represents website site path
  class Site
    attr_reader :visit_count, :uniq_visit_count

    def initialize(site_path)
      @site_path = site_path
      @uniq_visitors = {}
      @visit_count = 0
      @uniq_visit_count = 0
    end

    def visit(ip)
      @visit_count += 1
      @uniq_visit_count += 1 unless uniq_visitors.key?(ip)
      uniq_visitors[ip] ||= nil
    end

    def visit_print
      "#{site_path} #{visit_count} visits"
    end

    def uniq_visit_print
      "#{site_path} #{uniq_visit_count} unique views"
    end

    private

    attr_reader :site_path, :uniq_visitors
  end
end
