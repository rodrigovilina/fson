# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'maybe'
require_relative 'fson/equality'
require_relative 'fson/plus'
require_relative 'fson/minus'
require_relative 'fson/digit'
require_relative 'fson/digits'
require_relative 'fson/one_nine'


module FSON
  def self.parse_sign(str)
    case 
    when str[0] == '+' then Maybe.return([Plus.new, str[1..]])
    when str[0] == '-' then Maybe.return([Minus.new, str[1..]])
    else Maybe.none
    end
  end

  def self.parse_digit(str)
    case str[0]
    when '0'..'9' then Maybe.return([Digit.new(str[0].to_i), str[1..]])
    else Maybe.none
    end
  end

  def self.parse_digits(str)
    parse_digits_helper([], str)
  end

  def self.parse_digits_helper(digits, str)
    result = parse_digit(str)
    
    case
    when result.none? && digits.empty? then Maybe.none
    when result.none? then Maybe.return([Digits.new(digits), str])
    else 
      digits << result.value!.fetch(0)
      parse_digits_helper(digits, result.value!.fetch(1))
    end

  end

  def self.parse_one_nine(str)
    case str[0]
    when '1'..'9' then Maybe.return([OneNine.new(str[0].to_i), str[1..]])
    else Maybe.none
    end
  end
end
