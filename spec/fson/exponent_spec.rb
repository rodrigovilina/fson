# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Exponent do
  describe '.parse' do
    it 'does not parse an empty string' do
      str = ''
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses an exponent' do
      str = ['E', 'e'].sample
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses an exponent' do
      str = ['E-', 'E+', 'e-', 'e+'].sample
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses an exponent' do
      e_letter = ['E', 'e'].sample
      sign = ['+', '-', ''].sample
      sign_obj = FSON::Sign.parse(sign).value!.token
      digits = rand(1000).to_s
      digits_obj = FSON::Digits.parse(digits).value!.token

      str = [e_letter, sign, digits.to_s].join
      result = described_class.parse(str)
      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Exponent.new(sign_obj, digits_obj), '')))
    end
  end
end

