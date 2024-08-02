# frozen_string_literal: true

module FSON
  class OneNine
    def self.parse(string)
      case string[0]
      when '1'..'9' then Maybe.return(Result.new(OneNine.new(string[0]), string[1..]))
      else Maybe.none
      end
    end

    def self.sample
      ('1'..'9').to_a.sample
    end

    def initialize(digit)
      @digit = digit
    end

    def ==(other)
      self.class == other.class &&
        digit == other.digit
    end

    attr_reader :digit
  end
end
