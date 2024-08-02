# frozen_string_literal: true

module FSON
  class Hex
    def self.parse(string)
      char = string[0]

      case char
      when ('0'..'9'), ('a'..'f'), ('A'..'F') then Maybe.return(Result.new(new(char), string[1..]))
      end
    end

    def self.sample
      [*('0'..'9').to_a, *('a'..'f').to_a, *('A'..'F').to_a].sample
    end

    def initialize(char)
      @char = char
    end

    attr_reader :char

    def ==(other)
      self.class == other.class &&
        char.downcase == other.char.downcase
    end
  end
end
