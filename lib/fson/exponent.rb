# frozen_string_literal: true

module FSON
  class Exponent
    def self.parse(string)
      case string[0]
      when 'E', 'e' then
        sign = Sign.parse(string[1..]).value!
        maybe_digits = Digits.parse(sign.rest)

        maybe_digits.map do |digits|
          Result.new(FSON::Exponent.new(sign.token, digits.token), digits.rest)
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
