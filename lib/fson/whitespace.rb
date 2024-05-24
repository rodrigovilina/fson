# frozen_string_literal: true

module FSON
  class Whitespace
    def self.parse(string)
      char = string[0]

      case char
      when "\u0020", "\u0009", "\u000A", "\u000D" then Maybe.return(Result.new(Some.new(char), string[1..]))
      else Maybe.return(Result.new(None.new, string))
      end
    end

    class Some < self
      def initialize(char)
        @char = char
      end

      attr_reader :char

      def ==(other)
        self.class == other.class &&
          self.char == other.char
      end
    end

    class None < self
      def ==(other)
        self.class == other.class
      end
    end
  end
end
