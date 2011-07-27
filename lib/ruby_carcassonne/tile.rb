module RubyCarcassonne
  class Tile
    attr_reader :landmarks

    def initialize(*landmarks)
      @landmarks = landmarks
    end
  end
end
