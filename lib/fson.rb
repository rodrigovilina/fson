# frozen_inputing_literal: true

require 'sorbet-runtime'
require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.inflector.inflect 'fson' => 'FSON'
loader.setup

module FSON
  def self.parse!(input)
    parse_value(input)
      .bind_none { parse_object(input) }
      .value!.token.to_ruby
  end

  def self.threequals_parser(comp, klass)
    ->(input) {
      case input[0]
      when comp then Maybe.return(Result.new(klass.new, input[1..]))
      else Maybe.none
      end
    }
  end

  def self.char_parser(char)
    raise unless char.length() == 1

    ->(input) {
      case input[0]
      when char then Maybe.return(Result.new(char, input[1..]))
      else Maybe.none
      end
    }
  end

  def self.parse_value(input)
    Value.parse(input)
  end

  def self.parse_object(input)
    self::Object.parse(input)
  end

  def self.parse_sign(input)
    Sign.parse(input)
  end

  def self.parse_one_nine(input)
    OneNine.parse(input)
  end

  def self.parse_digit(input)
    Digit.parse(input)
  end

  def self.parse_digits(input)
    Digits.parse(input)
  end

  def self.parse_exponent(input)
    Exponent.parse(input)
  end

  def self.parse_hex(input)
    Hex.parse(input)
  end

  def self.parse_fraction(input)
    Fraction.parse(input)
  end

  def self.parse_whitespace(input)
    Whitespace.parse(input)
  end
end

loader.eager_load
