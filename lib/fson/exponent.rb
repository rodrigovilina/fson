# frozen_string_literal: true

module FSON
  class Exponent
    def self.parse(string)
      case string[0]
      when 'E', 'e'
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
      self.class == other.class && sign == other.sign && digits == other.digits
    end

    class None < self
      def initialize()
      end

      def ==(other)
        self.class == other.class
      end
    end

    class Some < self
      def self.sample
        [['e', 'E'].sample, FSON::Digits.sample].join('')
      end
    end
  end
end
