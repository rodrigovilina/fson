# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::OneNine do
  describe '.parse' do
    it 'does not parse an empty string' do
      str = ''
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    it 'parses digits one to nine' do
      str = (1..9).to_a.sample.to_s
      result = described_class.parse(str)
      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::OneNine.new(str), '')))
    end

    it 'parses only one digits one to nine' do
      digit = (1..9).to_a.sample
      str = "#{digit}#{digit}"
      result = described_class.parse(str)
      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::OneNine.new(digit.to_s), digit.to_s)))
    end
  end
end
