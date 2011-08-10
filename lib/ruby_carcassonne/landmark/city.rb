module RubyCarcassonne::Landmark
  class City < Base
    class SidesCoherenceError < Exception
    end

    class NoSidesError < Exception
    end

    def initialize(sides, shield = false)
      raise NoSidesError.new if sides == 0
      s = sides
      until s == 0 do
        wall = (s & 0b111)
        raise SidesCoherenceError.new unless wall == 0b111 || wall == 0b000
        s = s >> 3
      end
      super sides
      @shield = shield
    end

    def shield?
      @shield
    end

    def == other
      super && (@shield == other.shield?)
    end
  end
end
