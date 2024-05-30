# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Whitespace do
  describe '.parse' do
    it 'parses whitespace characters' do
      char = ["\u0020", "\u000A", "\u0009", "\u000D"].sample
      result = described_class.parse(char)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Whitespace::Some.new(char), '')))
    end

    it 'might be empty' do
      string = ''
      result = described_class.parse(string)

      expect(result).to eq(Maybe.return(FSON::Result.new(FSON::Whitespace::None.new, '')))
    end

    # flaky because sample can be none
    it 'parses multiple whitespace characters' do
      input = described_class.sample
      result = described_class.parse(input)

      expect(result).to eq(Maybe.return(FSON::Result.new(described_class::Some.new(input), '')))
    end
  end
end
