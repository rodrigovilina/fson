# frozen_string_literal: true

module FSON
  class Digits
    def self.parse(string)
      parse_digits_helper([], string)
    end

    def self.parse_digits_helper(digits, string)
      result = Digit.parse(string)

      case
      when result.none? && digits.empty? then Maybe.none
      when result.none? then Maybe.return(Result.new(Digits.new(digits), string))
      else
        digits << result.value!.token
        parse_digits_helper(digits, result.value!.rest)
      end
    end

    def self.sample
      [
        ('1'..'9').to_a.sample,
        *(rand(4) + 1).times.map { ('0'..'9').to_a.sample }
      ].join('')
    end

    def initialize(digits)
      @digits = digits.map { _1.digit.to_s }.join
    end

    attr_reader :digits

    def ==(other)
      self.class == other.class && digits == other.digits
    end
  end
end
