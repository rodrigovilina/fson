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
          FSON.char_parser('\\').(input)
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
        .bind_none do
          self::U.parse(input)
        end
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

    class U < self
      def initialize(hexes)
        @hexes = hexes
      end
      attr_reader :hexes

      def self.parse(input)
        u = FSON.char_parser('u').(input[0])
        return Maybe.none unless u.some?

        char_parser = FSON.char_include_parser([*('0'..'9').to_a, *('a'..'f').to_a, *('A'..'F').to_a])

        one = char_parser.(input[1])
        return Maybe.none unless one.some?

        two = char_parser.(input[2])
        return Maybe.none unless two.some?

        three = char_parser.(input[3])
        return Maybe.none unless three.some?

        four = char_parser.(input[4])
        return Maybe.none unless four.some?

        Maybe.return(Result.new(new([one, two, three, four].map { _1.value!.token }.join('')), input[5..]))
      end

      def ==(other)
        self.class == other.class &&
          hexes == other.hexes
      end
    end
  end
end
