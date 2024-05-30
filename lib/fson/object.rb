# frozen_string_literal: true

module FSON
  class Object
    def self.parse(input)
      FSON.char_parser('{').(input)
        .bind { |r| FSON.parse_whitespace(input[1..]) }
        .bind { |r| FSON.char_parser('}').(r.rest) }
        .bind { |r| Maybe.return(Result.new(new, r.rest)) }
    end

    def to_ruby
      {}
    end
  end
end
