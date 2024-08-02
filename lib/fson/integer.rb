# frozen_string_literal: true

module FSON
  class Integer
    def self.parse(input)
      NDigits.parse(input)
        .bind_none { Digits.parse(input) }
        .bind_none { NDigit.parse(input) }
        .bind_none { Digit.parse(input) }
    end

    def self.sample
      [self::Digit, self::NDigit, self::Digits, self::NDigits].sample.sample
    end

    class Digit < self
      def self.parse(input)
        FSON::Digit.parse(input).bind { |r| Maybe.return(Result.new(Digit.new(r.token.digit), r.rest)) }
      end

      def self.sample
        FSON::Digit.sample
      end

      def initialize(digit)
        @digit = digit
      end

      def to_s
        @digit
      end

      attr_reader :digit

      def ==(other)
        self.class == other.class &&
          self.digit == other.digit
      end
    end

    class NDigit < self
      def self.parse(input)
        FSON.char_parser('-').(input)
          .bind do |r|
            FSON::Digit.parse(r.rest)
              .bind { |rr| Maybe.return(Result.new(NDigit.new(rr.token.digit), rr.rest)) }
          end
      end

      def self.sample
        ['-', FSON::Digit.sample].join('')
      end

      def initialize(digit)
        @digit = digit
      end

      def to_s
        ['-', digit].join('')
      end

      attr_reader :digit

      def ==(other)
        self.class == other.class &&
          self.digit == other.digit
      end
    end

    class Digits < self
      def self.parse(input)
        OneNine.parse(input)
        .bind do |r| 
          FSON::Digits.parse(r.rest)
            .bind { |rr| Maybe.return(Result.new(new([r.token.digit, rr.token.digits].join('')), rr.rest)) }
        end
      end

      def self.sample
        FSON::Digits.sample
      end

      def initialize(digits)
        @digits = digits
      end

      def to_s
        @digits
      end

      attr_reader :digits

      def ==(other)
        self.class == other.class &&
          self.digits == other.digits
      end
    end

    class NDigits < self
      def self.parse(input)
        FSON.char_parser('-').(input).bind do |r|
          OneNine.parse(r.rest).bind do |rr| 
            FSON::Digits.parse(rr.rest)
              .bind { |rrr| Maybe.return(Result.new(new([rr.token.digit, rrr.token.digits].join('')), rrr.rest)) }
          end
        end
      end

      def self.sample
        ['-', FSON::Digits.sample].join('')
      end

      def initialize(digits)
        @digits = digits
      end

      def to_s
        ['-', @digits].join('')
      end

      attr_reader :digits

      def ==(other)
        self.class == other.class &&
          self.digits == other.digits
      end
    end
  end
end
