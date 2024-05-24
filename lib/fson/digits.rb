module FSON
  class Digits
    def self.parse(string)
      parse_digits_helper([], string)
    end

    def self.parse_digits_helper(digits, string)
      result = Digit.parse(string)

      case
      when result.none? && digits.empty? then Maybe.none
      when result.none? then Maybe.return([Digits.new(digits), string])
      else
        digits << result.value!.fetch(0)
        parse_digits_helper(digits, result.value!.fetch(1))
      end
    end

    def initialize(digits)
      @digits = digits.map { _1.digit.to_s }.join.to_i
    end

    attr_reader :digits

    def ==(other)
      self.class == other.class && self.digits == other.digits
    end
  end
end
