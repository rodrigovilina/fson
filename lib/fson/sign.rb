# frozen_string_literal: true

module FSON
  class Sign
    def self.parse(string)
      Plus.parse(string)
        .bind_none { Minus.parse(string) }
        .bind_none { None.parse(string) }
    end
        
    def ==(other)
      self.class == other.class
    end

    class Plus < self
      def self.parse(string)
        FSON.threequals_parser('+', self).(string)
      end
    end

    class Minus < self
      def self.parse(string)
        FSON.threequals_parser('-', self).(string)
      end
    end

    class None < self
      def self.parse(string)
        Maybe.return([new, string])
      end
    end
  end
end
