# frozen_string_literal: true

module FSON
  module Equality
    def ==(other)
      other.class == self.class
    end

    def eql(other)
      self == other
    end
  end
end
