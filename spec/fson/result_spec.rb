# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Result do
  describe '#initialize' do
    it 'takes a token and a string', :aggregate_failures do
      token = FSON::Sign::None.new
      string = ''
      result = described_class.new(token, string)

      expect(result.token).to eq(token)
      expect(result.rest).to eq(string)
    end
  end
end
