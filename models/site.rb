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

    def visit(ip); end

    def visit_print; end

    def uniq_visit_print; end
  end
end
