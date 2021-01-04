# frozen_string_literal: true

require_relative 'display_strategy'

module Models
  # Class implements display operation. Sites are sorted by site's overall visit count.
  class DisplayVisitsStrategy < DisplayStrategy
    def display(data)
      data.sort! { |a, b| b.visit_count <=> a.visit_count }
      data.map(&:visit_print)
    end
  end
end
