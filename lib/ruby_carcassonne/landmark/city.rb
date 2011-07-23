module RubyCarcassonne::Landmark
  class City < Base
    class SidesCoherenceError < Exception
    end

    class NoSidesError < Exception
    end

    def initialize(sides)
      raise NoSidesError.new if sides == 0
      s = sides
      until s == 0 do
        wall = (s & 0b111)
        raise SidesCoherenceError.new unless wall == 0b111 || wall == 0b000
        s = s >> 3
      end
      super
    end
  end
end
