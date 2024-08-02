# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Integer do
  describe '.parse' do
    it 'parses a single digit' do
      input = FSON::Digit.sample
      result = described_class.parse(input)

      expect(result.value!).to eq(FSON::Result.new(described_class::Digit.new(input), ''))
    end

    it 'parses a single negative digit' do
      digit = FSON::Digit.sample
      input = ['-', digit].join('')
      result = described_class.parse(input)

      expect(result.value!).to eq(FSON::Result.new(described_class::NDigit.new(digit), ''))
    end

    it 'parses a multi-digit integer' do
      onenine = FSON::OneNine.sample
      digits = FSON::Digits.sample
      input = [onenine, digits].join('')
      result = described_class.parse(input)

      expect(result).to eq(Maybe.return(FSON::Result.new(described_class::Digits.new(input), '')))
    end

    it 'parses a negative multi-digit integer' do
      digits = [FSON::OneNine.sample, FSON::Digits.sample].join('')
      input = ['-', digits].join('')
      result = described_class.parse(input)

      expect(result).to eq(Maybe.return(FSON::Result.new(described_class::NDigits.new(digits), '')))
    end
  end
end
