# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Number do
  describe '.parse' do
    it 'parses an integer number' do
      input = FSON::Integer.sample
      result = described_class.parse(input)
      expected = described_class.new(input, FSON::Fraction::None.new, FSON::Exponent::None.new)

      expect(result).to eq(Maybe.return(FSON::Result.new(expected, '')))
    end

    it 'parses a float number' do
      integer = FSON::Integer.sample
      fraction = FSON::Fraction::Some.sample
      input = [integer, fraction].join('')
      result = described_class.parse(input)
      expected = described_class.new(integer, fraction, FSON::Exponent::None.new)
    end

    it 'parses an integer number with exponent' do
      integer = FSON::Integer.sample
      exponent = FSON::Exponent::Some.sample
      input = [integer, exponent].join('')
      result = described_class.parse(input)
      expected = described_class.new(integer, FSON::Fraction::None, exponent)
    end

    it 'parses a float number with exponent' do
      integer = FSON::Integer.sample
      fraction = FSON::Fraction::Some.sample
      exponent = FSON::Exponent::Some.sample
      input = [integer, fraction, exponent].join('')
      result = described_class.parse(input)
      expected = described_class.new(integer, fraction, exponent)
    end
  end
end
