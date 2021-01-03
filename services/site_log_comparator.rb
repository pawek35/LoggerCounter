# frozen_string_literal: true

module Services
  # A service which returns an array fo site names, sorted by the most visited one
  class SiteLogComparator
    def initialize; end

    def call(number)
      number == 1
    end
  end
end
