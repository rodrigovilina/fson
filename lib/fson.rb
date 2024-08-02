# frozen_string_literal: true

require 'sorbet-runtime'
require 'zeitwerk'
require 'byebug'
loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.inflector.inflect 'fson' => 'FSON'
loader.setup

module FSON
  def self.parse!(input)
    parse_element(input).value!.token.to_ruby
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
    ->(input) {
      case input[0]
      when char then Maybe.return(Result.new(input[0], input[1..]))
      else Maybe.none
      end
    }
  end

  def self.char_include_parser(chars)
    ->(input) {
      case 
      when chars.include?(input[0]) then Maybe.return(Result.new(input[0], input[1..]))
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

  def self.parse_members(input)
    Members.parse(input)
  end

  def self.parse_member(input)
    Member.parse(input)
  end

  def self.parse_array(input)
    self::Array.parse(input)
  end

  def self.parse_elements(input)
    Elements.parse(input)
  end

  def self.parse_element(input)
    Element.parse(input)
  end

  def self.parse_string(input)
    self::String.parse(input)
  end

  def self.parse_characters(input)
    Characters.parse(input)
  end

  def self.parse_character(input)
    Character.parse(input)
  end

  def self.parse_escape(input)
    Escape.parse(input)
  end

  def self.parse_hex(input)
    Hex.parse(input)
  end

  def self.parse_number(input)
    Number.parse(input)
  end

  def self.parse_integer(input)
    self::Integer.parse(input)
  end

  def self.parse_digits(input)
    Digits.parse(input)
  end

  def self.parse_digit(input)
    Digit.parse(input)
  end

  def self.parse_one_nine(input)
    OneNine.parse(input)
  end

  def self.parse_fraction(input)
    Fraction.parse(input)
  end

  def self.parse_exponent(input)
    Exponent.parse(input)
  end

  def self.parse_sign(input)
    Sign.parse(input)
  end

  def self.parse_whitespace(input)
    Whitespace.parse(input)
  end
end

loader.eager_load
