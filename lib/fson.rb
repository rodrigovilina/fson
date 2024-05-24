# frozen_string_literal: true

require 'sorbet-runtime'
require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false)
loader.inflector.inflect "fson" => "FSON"
loader.setup 

module FSON
  def self.threequals_parser(comp, klass)
    ->(string) {
      case string[0]
      when comp then Maybe.return([klass.new, string[1..]])
      else Maybe.none
      end
    }
  end

  def self.parse_sign(str)
    Sign.parse(str)
  end

  def self.parse_one_nine(str)
    OneNine.parse(str)
  end

  def self.parse_digit(str)
    Digit.parse(str)
  end

  def self.parse_digits(str)
    Digits.parse(str)
  end

  def self.parse_exponent(str)
    Exponent.parse(str)
  end
end

loader.eager_load 
