module RubyCarcassonne::Tileset
  class Standard
    module Tiles
      class L < RubyCarcassonne::Tile
        def initialize
          super(
            Road.new(0b010010000000),
            Field.new(0b001100000000),
            Field.new(0b100001111111))
        end
      end
    end

    attr_reader :tiles

    def initialize
      @tiles = []
      9.times { @tiles << Tiles::L.new }
    end

    def each *args, &block
      @tiles.each *args, &block
    end
  end
end
