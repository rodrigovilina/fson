# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Digit do
  describe '.parse' do
    it 'does not parse an empty string' do
      str = ''
      result = described_class.parse(str)

      expect(result).to eq(Maybe.none)
    end

    it 'parses digits zero to nine' do
      string = ('0'..'9').to_a.sample
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Digit.new(string), '')))
    end

    it 'parses only one digit' do
      digit = ('0'..'9').to_a.sample
      string = "#{digit}#{digit}"
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Digit.new(digit), digit)))
    end
  end
end
