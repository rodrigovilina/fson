# frozen_string_literal: true

require_relative '../lib/fson'

RSpec.describe FSON do
  describe '.parse_exponent' do
    it 'does not parse an empty string' do
      str = ''
      result = FSON.parse_exponent(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses an exponent' do
      str = ['E', 'e'].sample
      result = FSON.parse_exponent(str)
      expect(result).to eq(Maybe.none())
    end

    it 'parses an exponent' do
      str = ['E-', 'E+', 'e-', 'e+'].sample
      result = FSON.parse_exponent(str)
      expect(result).to eq(Maybe.none())
    end

    it 'parses an exponent' do
      str = ['E-', 'E+', 'e-', 'e+'].sample
      digits = rand(1000)
      str = [str, digits.to_s].join
      result = FSON.parse_exponent(str)
      expect(result).to eq(Maybe.return([FSON::Exponent.new, '']))
    end
  end
end
