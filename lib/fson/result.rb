# frozen_string_literal: true

module FSON
  class Result
    def initialize(token, rest)
      @token = token
      @rest = rest
    end

    attr_reader :token, :rest

    def ==(other)
      self.class == other.class && 
        self.token == other.token &&
        self.rest == other.rest
    end
  end
end
