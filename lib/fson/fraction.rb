# frozen_string_literal: true

module FSON
  class Fraction
    def self.parse(string)
      if string[0] == "."
        digits = Digits.parse(string[1..])

        if digits.none?
          Maybe.return Result.new(None.new, string)
        else
          Maybe.return Result.new(Some.new(digits.value!.token), digits.value!.rest)
        end
      else
        Maybe.return Result.new(None.new, string)
      end
    end

    class None < self
      def ==(other)
        self.class == other.class
      end
    end

    class Some < self
      def initialize(digits)
        @digits = digits
      end

      attr_reader :digits

      def ==(other)
        self.class == other.class &&
          self.digits == other.digits
      end
    end
  end
end
