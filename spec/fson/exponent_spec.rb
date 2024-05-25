# frozen_string_literal: true

require_relative '../../lib/fson'

RSpec.describe FSON::Exponent do
  describe '.parse' do
    it 'does not parse an empty string' do
      str = ''
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    it 'does not parse just an "E" letter' do
      str = %w[E e].sample
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    it 'does not parse if there are no digits' do
      str = ['E-', 'E+', 'e-', 'e+'].sample
      result = described_class.parse(str)
      expect(result).to eq(Maybe.none)
    end

    context 'when successful' do
      let(:sign) { ['+', '-', ''].sample }
      let(:digits) { rand(1000).to_s }
      let(:string) do
        e_letter = %w[E e].sample
        [e_letter, sign, digits.to_s].join
      end
      let(:sign_obj) { FSON::Sign.parse(sign).value!.token }
      let(:digits_obj) { FSON::Digits.parse(digits).value!.token }

      it 'parses an exponent' do
        actual = described_class.parse(string)
        expected = Maybe.return(
          FSON::Result.new(described_class.new(sign_obj, digits_obj), '')
        )

        expect(actual).to eq(expected)
      end
    end
  end
end
