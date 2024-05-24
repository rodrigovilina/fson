# frozen_string_literal: true

module FSON
  class Hex
    def self.parse(string)
      char = string[0]

      case char
      when ('0'..'9'), ('a'..'f'), ('A'..'F') then Maybe.return(Result.new(new(char), string[1..]))
      end
    end

    def initialize(char)
      @char = char
    end

    attr_reader :char

    def ==(other)
      self.class == other.class &&
        self.char.downcase == other.char.downcase
    end
  end
end
