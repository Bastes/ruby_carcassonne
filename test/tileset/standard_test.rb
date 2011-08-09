require_relative '../helper'

class StandardTilesetTest < Test::Unit::TestCase
  context("The standard tileset") {
    should_have_tiles = lambda { |number, designation, classname, template|
      should("present #{designation} tiles") {
        assert_equal template, classname.new
      }
      context("instance") {
        setup {
          @tileset = RubyCarcassonne::Tileset::Standard.new
        }
        should("contain #{number} different #{designation} tiles") {
          tiles = @tileset.tiles.select { |tile| tile == template }
          assert_equal number, tiles.length
          (0..(number - 2)).each { |i| ((i + 1)..(number - 1)).each { |j|
            assert !tiles[i].equal?(tiles[j]) } }
        }
      }
    }

    should_have_tiles.call(
      9,
      "L-shaped road",
      RubyCarcassonne::Tileset::Standard::Tiles::L,
      Tile.new(
        Road.new(0b010010000000),
        Field.new(0b001100000000),
        Field.new(0b100001111111)))
    should_have_tiles.call(
      8,
      "I-shaped road",
      RubyCarcassonne::Tileset::Standard::Tiles::I,
      Tile.new(
        Field.new(0b100000001111),
        Road.new(0b010000010000),
        Field.new(0b001111100000)))
    should_have_tiles.call(
      4,
      "T-shaped road",
      RubyCarcassonne::Tileset::Standard::Tiles::T,
      Tile.new(
        Field.new(0b100000001111),
        Road.new(0b010000000000),
        Field.new(0b001100000000),
        Road.new(0b000010000000),
        Field.new(0b000001100000),
        Road.new(0b000000010000)))
    should_have_tiles.call(
      1,
      "crossroads",
      RubyCarcassonne::Tileset::Standard::Tiles::X,
      Tile.new(
        Field.new(0b100000000001),
        Road.new(0b010000000000),
        Field.new(0b001100000000),
        Road.new(0b000010000000),
        Field.new(0b000001100000),
        Road.new(0b000000010000),
        Field.new(0b000000001100),
        Road.new(0b000000000010)))
    should_have_tiles.call(
      5,
      "single city",
      RubyCarcassonne::Tileset::Standard::Tiles::C,
      Tile.new(
        City.new(0b111000000000),
        Field.new(0b000111111111)))
    should_have_tiles.call(
      3,
      "L-shaped road near a single city",
      RubyCarcassonne::Tileset::Standard::Tiles::LC,
      Tile.new(
        Field.new(0b100001000111),
        Road.new(0b010010000000),
        Field.new(0b001100000000),
        City.new(0b000000111000)))
    should_have_tiles.call(
      3,
      "I-shaped road near a single city",
      RubyCarcassonne::Tileset::Standard::Tiles::IC,
      Tile.new(
        Field.new(0b100000001111),
        Road.new(0b010000010000),
        Field.new(0b001000100000),
        City.new(0b000111000000)))
    should_have_tiles.call(
      3,
      "single city near an L-shaped road",
      RubyCarcassonne::Tileset::Standard::Tiles::CL,
      Tile.new(
        City.new(0b111000000000),
        Field.new(0b000100001111),
        Road.new(0b000010010000),
        Field.new(0b000001100000)))
  }
end
