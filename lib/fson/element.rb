# frozen_string_literal: true

module FSON
  class Element
    def self.parse(input)
      Whitespace.parse(input).bind do |r|
        Value.parse(r.rest).bind do |rr|
          Whitespace.parse(rr.rest).map do |rrr|
            Result.new(new(rr.token), rrr.rest)
          end
        end
      end
    end

    def initialize(value)
      @value = value
    end

    attr_reader :value

    def ==(other)
      self.class == other.class &&
        self.value == other.value
    end

    def to_ruby
      value.to_ruby
    end
  end
end
