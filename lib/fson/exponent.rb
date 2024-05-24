# frozen_string_literal: true

module FSON
  class Exponent
    def self.parse(string)
      case string[0]
      when 'E', 'e' then
        sign = Sign.parse(string[1..]).value!
        maybe_digits = Digits.parse(sign.fetch(1))

        maybe_digits.map do |digits|
          [FSON::Exponent.new(sign.fetch(0), digits.fetch(0)), digits.fetch(1)]
        end
      else Maybe.none
      end
    end

    def initialize(sign, digits)
      @sign = sign
      @digits = digits
    end

    attr_reader :sign, :digits

    def ==(other)
      self.class == other.class && self.sign == other.sign && self.digits == other.digits
    end
  end
end
