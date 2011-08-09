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
      class I < RubyCarcassonne::Tile
        def initialize
          super(
            Field.new(0b100000001111),
            Road.new(0b010000010000),
            Field.new(0b001111100000))
        end
      end
    end

    attr_reader :tiles

    def initialize
      @tiles = []
      9.times { @tiles << Tiles::L.new }
      8.times { @tiles << Tiles::I.new }
    end

    def each *args, &block
      @tiles.each *args, &block
    end
  end
end
