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
      @landmarks = landmarks.sort
    end

    [:clockwise, :back, :counterclockwise].each do |rotation|
      define_method(rotation) do
        self.class.new(*@landmarks.map(&rotation))
      end
    end

    def side(direction)
      mask = RubyCarcassonne::Landmark::Base::CONTACTS[direction]
      @landmarks.detect { |l| l.sides & mask > 0 }
    end

    def connects?(other, direction)
      opposite = RubyCarcassonne::Landmark::Base::OPPOSITE[direction]
      side(direction).class == other.side(opposite).class
    end

    def ==(other)
      landmarks == other.landmarks
    end
  end
end
