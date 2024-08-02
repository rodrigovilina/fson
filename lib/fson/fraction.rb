# frozen_string_literal: true

module FSON
  class Fraction
    def self.parse(string)
      if string[0] == '.'
        digits = Digits.parse(string[1..])

        parse_digits(digits, string)
      else
        Maybe.return Result.new(None.new, string)
      end
    end

    def self.parse_digits(maybe_digits, string)
      maybe_digits
        .map { |digits| Result.new(Some.new(digits.token), digits.rest) }
        .map_none { Result.new(None.new, string) }
    end

    class None < self
      def ==(other)
        self.class == other.class
      end

      def none?
        true
      end
    end

    class Some < self
      def initialize(digits) # rubocop:disable Lint/MissingSuper
        @digits = digits
      end

      def self.sample
        ['.', FSON::Digits.sample].join('')
      end

      attr_reader :digits

      def ==(other)
        self.class == other.class &&
          digits == other.digits
      end

      def none?
        false
      end
    end
  end
end
