# frozen_string_literal: true

require_relative '../lib/fson'

RSpec.describe FSON do
  describe '.parse' do
    it 'parses "null"' do
      result = described_class.parse!("null")

      expect(result).to be_nil
    end

    it 'parses "true"' do
      result = described_class.parse!("true")

      expect(result).to be true
    end

    it 'parses "false"' do
      result = described_class.parse!("false")

      expect(result).to be false
    end

    it 'parses an empty object' do
      result = described_class.parse!("{}")

      expect(result).to eq({})
    end
  end
end
