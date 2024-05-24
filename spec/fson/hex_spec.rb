# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Hex do
  describe '.parse' do
    it 'parses any digit and letter from "a" to "f"' do
      char = [*(0..9).to_a, *('a'..'f').to_a, *('A'..'F').to_a].sample.to_s
      result = described_class.parse(char)
      token = described_class.new(char)

      expect(result).to eq(Maybe.return(FSON::Result.new(token, '')))
    end
  end
end
