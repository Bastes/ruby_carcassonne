module RubyCarcassonne
  class Tile
    class InvalidTileError < Exception
    end

    attr_reader :landmarks

    def initialize(*landmarks)
      sum = landmarks.inject(0) { |r, l|
        raise InvalidTileError.new unless (r & l.sides) == 0
        r | l.sides
      }
      raise InvalidTileError.new unless sum == 0b111111111111
      @landmarks = landmarks
    end
  end
end
