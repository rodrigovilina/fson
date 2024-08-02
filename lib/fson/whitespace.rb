# frozen_string_literal: true

module FSON
  class Whitespace
    def self.parse(input)
      parse_whitespaces_helper([], input)
    end

    def self.parse_whitespaces_helper(whitespaces, input)
      result = FSON.char_parser("\u0020").(input)
                   .bind_none { FSON.char_parser("\u0009").(input) }
                   .bind_none { FSON.char_parser("\u000A").(input) }
                   .bind_none { FSON.char_parser("\u000D").(input) }

      case
      when result.none? && whitespaces.empty?
        Maybe.return(Result.new(None.new, input))
      when result.none?
        Maybe.return(Result.new(Some.new(whitespaces.join), input))
      else
        whitespaces << result.value!.token
        parse_whitespaces_helper(whitespaces, result.value!.rest)
      end
    end

    def self.sample
      rand(10).times.map do
        ['', "\u0020", "\u0009", "\u000A", "\u000D"].sample
      end.join
    end

    class Some < self
      def initialize(char) # rubocop:disable Lint/MissingSuper
        @char = char
      end

      attr_reader :char

      def ==(other)
        self.class == other.class &&
          char == other.char
      end
    end

    class None < self
      def ==(other)
        self.class == other.class
      end
    end
  end
end
