# frozen_string_literal: true
#
require_relative '../../lib/fson'

RSpec.describe FSON::Digits do
  describe '.parse' do
    it 'does not parse an empty string' do
      str = ''
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses a single digit' do
      string = (0..9).to_a.sample.to_s
      result = described_class.parse(string)
      digit = FSON::Digit.new(string)

      expect(result).to eq(Maybe.return([FSON::Digits.new([digit]), '']))
    end
  end
end
