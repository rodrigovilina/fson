# frozen_string_literal: true

module FSON
  class Number
    def self.parse(input)
      FSON::Integer.parse(input).bind do |r|
        Fraction.parse(r.rest).bind do |fraction|
          Maybe.return(Result.new(new(r.token.to_s, fraction.token, Exponent::None.new), r.rest))
        end
      end
    end

    def initialize(integer, fraction, exponent)
      @integer = integer
      @fraction = fraction
      @exponent = exponent
    end

    attr_reader :integer, :fraction, :exponent

    def ==(other)
      self.class == other.class &&
        self.integer == other.integer &&
        self.fraction == other.fraction &&
        self.exponent == other.exponent
    end

    def to_ruby
      if fraction.none?
        @integer.to_i
      else
        [@integer, '.', @fraction.digits.digits].join('').to_f
      end
    end
  end
end
