# frozen_string_literal: true

require_relative '../lib/fson'

RSpec.describe FSON do
  describe '.parse_sign' do
    it 'does not parse an empty string' do
      str = ''
      result = FSON.parse_sign(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses a plus sign' do
      str = '+'
      result = FSON.parse_sign(str)
      expect(result).to eq(Maybe.return([FSON::Plus.new, '']))
    end

    it 'parses a minus sign' do
      str = '-'
      result = FSON.parse_sign(str)
      expect(result).to eq(Maybe.return([FSON::Minus.new, '']))
    end
  end
end
