module FSON
  class Digit
    def self.parse(string)
      case string[0]
      when '0'..'9' then Maybe.return([Digit.new(string[0]), string[1..]])
      else Maybe.none
      end
    end

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
