# frozen_input_literal: true

module FSON
  class Value
    def self.parse(input)
      Whitespace.parse(input).bind do |r|
        Null.parse(r.rest) 
          .bind_none { True.parse(r.rest) }
          .bind_none { False.parse(r.rest) }
      end
    end

    class Null < self
      def self.parse(input)
        if input[0..3] == "null"
          Maybe.return(Result.new(new, input[4..]))
        else
          Maybe.none
        end
      end

      def to_ruby
        nil
      end
    end

    class True < self
      def self.parse(input)
        if input[0..3] == "true"
          Maybe.return(Result.new(new, input[4..]))
        else
          Maybe.none
        end
      end

      def to_ruby
        true
      end
    end

    class False < self
      def self.parse(input)
        if input[0..4] == "false"
          Maybe.return(Result.new(new, input[5..]))
        else
          Maybe.none
        end
      end

      def to_ruby
        false
      end
    end
  end
end
