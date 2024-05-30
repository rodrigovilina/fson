# frozen_string_literal: true

# escape
 #    '"'
 #    '\'
 #    '/'
 #    'b'
 #    'f'
 #    'n'
 #    'r'
 #    't'
 #    'u' hex hex hex hex
module FSON
  class Escape
    def self.parse(input)
      FSON.char_parser('"').(input)
        .bind { |r| Maybe.return(Result.new(DQ.new, r.rest)) }
        .bind_none do
          FSON.char_parser('/').(input)
            .bind { |r| Maybe.return(Result.new(Slash.new, r.rest)) }
        end
        .bind_none do
          FSON.char_parser("\\").(input)
            .bind { |r| Maybe.return(Result.new(BackSlash.new, r.rest)) }
        end
        .bind_none do
          FSON.char_parser('b').(input)
            .bind { |r| Maybe.return(Result.new(B.new, r.rest)) }
        end
        .bind_none do
          FSON.char_parser('r').(input)
            .bind { |r| Maybe.return(Result.new(R.new, r.rest)) }
        end
        .bind_none do
          FSON.char_parser('n').(input)
            .bind { |r| Maybe.return(Result.new(N.new, r.rest)) }
        end
        .bind_none do
          FSON.char_parser('t').(input)
            .bind { |r| Maybe.return(Result.new(T.new, r.rest)) }
        end
        .bind_none do
          FSON.char_parser('f').(input)
            .bind { |r| Maybe.return(Result.new(F.new, r.rest)) }
        end

        # .bind_none { FSON.char_parser("\u0009").(input) }
        # .bind_none { FSON.char_parser("\u000A").(input) }
        # .bind_none { FSON.char_parser("\u000D").(input) }
    end

    class DQ < self
      def ==(other)
        self.class == other.class
      end
    end

    class Slash < self
      def ==(other)
        self.class == other.class
      end
    end

    class BackSlash < self
      def ==(other)
        self.class == other.class
      end
    end

    class B < self
      def ==(other)
        self.class == other.class
      end
    end

    class N < self
      def ==(other)
        self.class == other.class
      end
    end

    class R < self
      def ==(other)
        self.class == other.class
      end
    end

    class T < self
      def ==(other)
        self.class == other.class
      end
    end

    class F < self
      def ==(other)
        self.class == other.class
      end
    end
  end
end
