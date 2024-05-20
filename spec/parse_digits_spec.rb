# frozen_string_literal: true
require_relative '../lib/fson'

RSpec.describe FSON do
  describe '.parse_digits' do
    it 'does not parse an empty string' do
      str = ''
      result = FSON.parse_digits(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses a single digit' do
      digit = rand(10)
      str = digit.to_s
      result = FSON.parse_digits(str)
      digit = FSON::Digit.new(digit)
      expect(result).to eq(Maybe.return([FSON::Digits.new([digit]), '']))
    end
  end
end
