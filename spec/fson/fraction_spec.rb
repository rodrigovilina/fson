# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Fraction do
  describe '.parse' do
    it 'might be empty' do
      string = ''
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(described_class::None.new, "")))
    end

    it 'needs digits' do
      string = "."
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(described_class::None.new, string)))
    end

    it 'parses the fraction' do
      string = ".1"
      result = described_class.parse(string)
      digits = FSON::Digits.parse(string[1..]).value!.token

      token = described_class::Some.new(digits)

      expect(result).to eq(Maybe.return(FSON::Result.new(token, "")))
    end
  end
end
