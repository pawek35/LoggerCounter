# frozen_string_literal: true

module Models
  # The Strategy interface declares display operation which will be implemented by Concrete Stretegies.
  class DisplayStrategy
    def display(_data)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end
