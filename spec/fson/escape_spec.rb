# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Escape do
  describe '.parse' do
    it 'parses a double quote' do
      string = '"'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::DQ.new, '')))
    end

    it 'parses a slash' do
      string = '/'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::Slash.new, '')))
    end

    it 'parses a backslash' do
      string = '\\'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::BackSlash.new, '')))
    end

    it 'parses a "b"' do
      string = 'b'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::B.new, '')))
    end

    it 'parses a "f"' do
      string = 'f'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::F.new, '')))
    end

    it 'parses a "n"' do
      string = 'n'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::N.new, '')))
    end

    it 'parses a "r"' do
      string = 'r'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::R.new, '')))
    end

    it 'parses a "t"' do
      string = 't'
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::T.new, '')))
    end

    it 'parses a "u" plus exactly four hexes' do
      hexes = 4.times.map { FSON::Hex.sample }.join
      string = "u#{hexes}"
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Escape::U.new(hexes), '')))
    end
  end
end
