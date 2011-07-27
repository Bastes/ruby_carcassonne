module RubyCarcassonne
  class Tile
    class InvalidTileError < Exception
    end

    attr_reader :landmarks

    def initialize(*landmarks)
      raise InvalidTileError.new unless landmarks.inject(0) { |r, l| r | l.sides } == 0b111111111111
      @landmarks = landmarks
    end
  end
end
