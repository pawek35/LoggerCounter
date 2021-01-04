# frozen_string_literal: true

require_relative 'display_strategy'

module Models
  # Class implements display operation. Sites are sorted by site's unique visit count.
  class DisplayUniqVisitsStrategy < DisplayStrategy
    def display(data)
      data.sort! { |a, b| b.uniq_visit_count <=> a.uniq_visit_count }
      data.map(&:uniq_visit_print)
    end
  end
end
