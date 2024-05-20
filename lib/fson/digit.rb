module FSON
  class Digit
    def initialize(digit)
      @digit = digit
    end

    def ==(other)
      self.class == other.class &&
        self.digit == other.digit
    end

    attr_reader :digit
  end
end
