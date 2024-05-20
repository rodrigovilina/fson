# frozen_string_literal: true

require_relative 'fson/equality'
require_relative 'fson/plus'
require_relative 'fson/minus'
require_relative 'fson/digit'
require_relative 'fson/digits'
require_relative 'fson/one_nine'


module FSON
  def self.parse_sign(str)
    case 
    when str[0] == '+' then [Plus.new, str[1..]]
    when str[0] == '-' then [Minus.new, str[1..]]
    else [nil, '']
    end
  end

  def self.parse_digit(str)
    case str[0]
    when '0'..'9' then [Digit.new(str[0].to_i), str[1..]]
    else [nil, str]
    end
  end

  def self.parse_digits(str)
    digits = []

    loop do
      digit_and_rest = parse_digit(str)
      digit, rest = digit_and_rest
      return [nil, rest] unless digit
      digits << digit
    end

    return [digits, rest]
  end

  def self.parse_one_nine(str)
    case str[0]
    when '1'..'9' then [OneNine.new(str[0].to_i), str[1..]]
    else [nil, '']
    end
  end
end
