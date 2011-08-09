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
      class T < RubyCarcassonne::Tile
        def initialize
          super(
            Field.new(0b100000001111),
            Road.new(0b010000000000),
            Field.new(0b001100000000),
            Road.new(0b000010000000),
            Field.new(0b000001100000),
            Road.new(0b000000010000))
        end
      end
      class X < RubyCarcassonne::Tile
        def initialize
          super(
            Field.new(0b100000000001),
            Road.new(0b010000000000),
            Field.new(0b001100000000),
            Road.new(0b000010000000),
            Field.new(0b000001100000),
            Road.new(0b000000010000),
            Field.new(0b000000001100),
            Road.new(0b000000000010))
        end
      end
    end

    attr_reader :tiles

    def initialize
      @tiles = {
        Tiles::L => 9,
        Tiles::I => 8,
        Tiles::T => 4,
        Tiles::X => 1
      }.inject([]) { |r, p| r + Array.new(p[1]) { p[0].new } }
    end

    def each *args, &block
      @tiles.each *args, &block
    end
  end
end
