# frozen_string_literal: true

require_relative '../lib/fson'
require 'faker'

RSpec.describe FSON do
  describe '.parse' do
    it 'parses "null"' do
      bws = described_class::Whitespace.sample
      aws = described_class::Whitespace.sample

      result = described_class.parse!("#{bws}null#{aws}")

      expect(result).to be_nil
    end

    it 'parses "true"' do
      bws = described_class::Whitespace.sample
      aws = described_class::Whitespace.sample
      result = described_class.parse!("#{bws}true#{aws}")

      expect(result).to be true
    end

    it 'parses "false"' do
      bws = described_class::Whitespace.sample
      aws = described_class::Whitespace.sample
      result = described_class.parse!("#{bws}false#{aws}")

      expect(result).to be false
    end

    it 'parses an empty object' do
      bws = described_class::Whitespace.sample
      aws = described_class::Whitespace.sample
      iws = described_class::Whitespace.sample
      result = described_class.parse!("#{bws}{#{iws}}#{aws}")

      expect(result).to eq({})
    end

    it 'parses an empty array' do
      bws = described_class::Whitespace.sample
      aws = described_class::Whitespace.sample
      iws = described_class::Whitespace.sample
      result = described_class.parse!("#{bws}[#{iws}]#{aws}")

      expect(result).to eq([])
    end

    it 'parses an empty string' do
      bws = described_class::Whitespace.sample
      aws = described_class::Whitespace.sample
      result = described_class.parse!("#{bws}\"\"#{aws}")

      expect(result).to eq('')
    end

    it 'parses an integer' do
      bws = described_class::Whitespace.sample
      aws = described_class::Whitespace.sample
      int = rand(9999).to_s
      input = "#{bws}#{int}#{aws}"
      result = described_class.parse!(input)

      expect(result).to eq(int.to_i)
    end

    it 'parses a float number' do
      input = Faker::Number.positive
      result = described_class.parse!(input.to_s)

      expect(result).to eq(input)
    end
  end
end
