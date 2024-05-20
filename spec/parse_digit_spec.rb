# frozen_string_literal: true

require_relative '../lib/fson'

RSpec.describe FSON do
  describe '.parse_digit' do
    it 'does not parse an empty string' do
      str = ''
      result = FSON.parse_digit(str)
      expect(result).to eq([nil, ''])
    end

    it 'parses digits zero to nine' do
      digit = rand(10)
      str = digit.to_s
      result = FSON.parse_digit(str)
      expect(result).to eq([FSON::Digit.new(digit), ''])
    end

    it 'parses only one digit' do
      digit = rand(10)
      str = "#{digit}#{digit}"
      result = FSON.parse_one_nine(str)
      expect(result).to eq([FSON::OneNine.new(digit), digit.to_s])
    end
  end
end
