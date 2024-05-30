# frozen_string_literal: true

module FSON
  class Array
    def self.parse(input)
      FSON.parse_whitespace(input).bind do |r|
        FSON.char_parser('[').(r.rest)
          .bind { |rr| FSON.parse_whitespace(r.rest[1..]) }
          .bind { |rr| FSON.char_parser(']').(rr.rest) }
          .bind { |rr| Maybe.return(Result.new(new, rr.rest)) }
      end
    end

    def to_ruby
      []
    end
  end
end
