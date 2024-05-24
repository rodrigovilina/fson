# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Sign do
  describe '.parse' do
    it 'parses a plus sign' do
      string = '+'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return([FSON::Sign::Plus.new, '']))
    end

    it 'parses a minus sign' do
      string = '-'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return([FSON::Sign::Minus.new, '']))
    end

    it 'returns a none when it cannot parse' do
      string = 'a'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return([FSON::Sign::None.new, 'a']))
    end
  end
end
