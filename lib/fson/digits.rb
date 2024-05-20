module FSON
  class Digits
    def initialize(digits)
      @digits = digits.map { _1.digit.to_s }.join.to_i
    end

    attr_reader :digits
    
    def ==(other)
      self.class == other.class && self.digits == other.digits
    end
  end
end
