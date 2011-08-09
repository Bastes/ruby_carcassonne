require_relative '../helper'

class StandardTilesetTest < Test::Unit::TestCase
  context("The standard tileset") {
    should("exist") {
      assert_nothing_raised { RubyCarcassonne::Tileset::Standard }
    }
    should("exhibit L-shaped road tiles") {
      template = Tile.new(
        Road.new(0b010010000000),
        Field.new(0b001100000000),
        Field.new(0b100001111111))
      tile = RubyCarcassonne::Tileset::Standard::Tiles::L.new
      assert_equal template, tile
    }
    should("exhibit I-shaped road tiles") {
      template = Tile.new(
        Field.new(0b100000001111),
        Road.new(0b010000010000),
        Field.new(0b001111100000))
      tile = RubyCarcassonne::Tileset::Standard::Tiles::I.new
      assert_equal template, tile
    }
    context("instance") {
      setup {
        @tileset = RubyCarcassonne::Tileset::Standard.new
      }
      should("contain 9 different L-shaped road tiles") {
        template = RubyCarcassonne::Tileset::Standard::Tiles::L.new
        tiles = @tileset.tiles.select { |tile| tile == template }
        assert_equal 9, tiles.length
        (0..7).each { |i| ((i + 1)..8).each { |j|
          assert !tiles[i].equal?(tiles[j]) } }
      }
      should("contain 8 different I-shaped road tiles") {
        template = RubyCarcassonne::Tileset::Standard::Tiles::I.new
        tiles = @tileset.tiles.select { |tile| tile == template }
        assert_equal 8, tiles.length
        (0..6).each { |i| ((i + 1)..7).each { |j|
          assert !tiles[i].equal?(tiles[j]) } }
      }
    }
  }
end
