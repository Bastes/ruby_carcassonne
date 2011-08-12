require_relative '../helper'

class StandardTilesetTest < Test::Unit::TestCase
  context("The standard tileset") {
    should_have_tiles = lambda { |number, designation, classname, template|
      should("present #{designation} tiles") {
        assert_equal template, classname.generate
      }
      context("instance") {
        setup {
          @tileset = RubyCarcassonne::Tileset::Standard.new
        }
        should("contain #{number} different #{designation} tiles") {
          tiles = @tileset.select { |tile| tile == template }
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
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Road. new(0b010010000000),
        RubyCarcassonne::Landmark::Field.new(0b001100000000),
        RubyCarcassonne::Landmark::Field.new(0b100001111111)))
    should_have_tiles.call(
      8,
      "I-shaped road",
      RubyCarcassonne::Tileset::Standard::Tiles::I,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b100000001111),
        RubyCarcassonne::Landmark::Road. new(0b010000010000),
        RubyCarcassonne::Landmark::Field.new(0b001111100000)))
    should_have_tiles.call(
      4,
      "T-shaped road",
      RubyCarcassonne::Tileset::Standard::Tiles::T,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b111100000001),
        RubyCarcassonne::Landmark::Road. new(0b000010000000),
        RubyCarcassonne::Landmark::Field.new(0b000001100000),
        RubyCarcassonne::Landmark::Road. new(0b000000010000),
        RubyCarcassonne::Landmark::Field.new(0b000000001100),
        RubyCarcassonne::Landmark::Road. new(0b000000000010)))
    should_have_tiles.call(
      1,
      "crossroads",
      RubyCarcassonne::Tileset::Standard::Tiles::X,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b100000000001),
        RubyCarcassonne::Landmark::Road. new(0b010000000000),
        RubyCarcassonne::Landmark::Field.new(0b001100000000),
        RubyCarcassonne::Landmark::Road. new(0b000010000000),
        RubyCarcassonne::Landmark::Field.new(0b000001100000),
        RubyCarcassonne::Landmark::Road. new(0b000000010000),
        RubyCarcassonne::Landmark::Field.new(0b000000001100),
        RubyCarcassonne::Landmark::Road. new(0b000000000010)))
    should_have_tiles.call(
      5,
      "single city",
      RubyCarcassonne::Tileset::Standard::Tiles::C,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b000111000000),
        RubyCarcassonne::Landmark::Field.new(0b111000111111)))
    should_have_tiles.call(
      3,
      "L-shaped road near a single city",
      RubyCarcassonne::Tileset::Standard::Tiles::LC,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b100001000111),
        RubyCarcassonne::Landmark::Road. new(0b010010000000),
        RubyCarcassonne::Landmark::Field.new(0b001100000000),
        RubyCarcassonne::Landmark::City. new(0b000000111000)))
    should_have_tiles.call(
      4,
      "I-shaped road near a single city",
      RubyCarcassonne::Tileset::Standard::Tiles::IC,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b100000001111),
        RubyCarcassonne::Landmark::Road. new(0b010000010000),
        RubyCarcassonne::Landmark::Field.new(0b001000100000),
        RubyCarcassonne::Landmark::City. new(0b000111000000)))
    should_have_tiles.call(
      3,
      "single city near an L-shaped road",
      RubyCarcassonne::Tileset::Standard::Tiles::CL,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111000000000),
        RubyCarcassonne::Landmark::Field.new(0b000100001111),
        RubyCarcassonne::Landmark::Road. new(0b000010010000),
        RubyCarcassonne::Landmark::Field.new(0b000001100000)))
    should_have_tiles.call(
      3,
      "T-shaped road near a single city",
      RubyCarcassonne::Tileset::Standard::Tiles::CT,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b000100000001),
        RubyCarcassonne::Landmark::Road. new(0b000010000000),
        RubyCarcassonne::Landmark::Field.new(0b000001100000),
        RubyCarcassonne::Landmark::Road. new(0b000000010000),
        RubyCarcassonne::Landmark::Field.new(0b000000001100),
        RubyCarcassonne::Landmark::Road. new(0b000000000010),
        RubyCarcassonne::Landmark::City. new(0b111000000000)))
    should_have_tiles.call(
      3,
      "two-sides city",
      RubyCarcassonne::Tileset::Standard::Tiles::D,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111111000000),
        RubyCarcassonne::Landmark::Field.new(0b000000111111)))
    should_have_tiles.call(
      3,
      "L-shaped road next to a two-sides city",
      RubyCarcassonne::Tileset::Standard::Tiles::LD,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b100001000000),
        RubyCarcassonne::Landmark::Road. new(0b010010000000),
        RubyCarcassonne::Landmark::Field.new(0b001100000000),
        RubyCarcassonne::Landmark::City. new(0b000000111111)))
    should_have_tiles.call(
      1,
      "H-shaped city",
      RubyCarcassonne::Tileset::Standard::Tiles::H,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b111000111000),
        RubyCarcassonne::Landmark::City. new(0b000111000111)))
    should_have_tiles.call(
      3,
      "A-shaped city",
      RubyCarcassonne::Tileset::Standard::Tiles::A,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111111000111),
        RubyCarcassonne::Landmark::Field.new(0b000000111000)))
    should_have_tiles.call(
      1,
      "A-shaped city with a road",
      RubyCarcassonne::Tileset::Standard::Tiles::AR,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111111000111),
        RubyCarcassonne::Landmark::Field.new(0b000000100000),
        RubyCarcassonne::Landmark::Road. new(0b000000010000),
        RubyCarcassonne::Landmark::Field.new(0b000000001000)))
    should_have_tiles.call(
      2,
      "cities in a corner",
      RubyCarcassonne::Tileset::Standard::Tiles::CC,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111000000000),
        RubyCarcassonne::Landmark::City. new(0b000111000000),
        RubyCarcassonne::Landmark::Field.new(0b000000111111)))
    should_have_tiles.call(
      3,
      "cities face to face",
      RubyCarcassonne::Tileset::Standard::Tiles::CFC,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111000000000),
        RubyCarcassonne::Landmark::Field.new(0b000111000111),
        RubyCarcassonne::Landmark::City. new(0b000000111000)))
    should_have_tiles.call(
      2,
      "shileded 2-sides city",
      RubyCarcassonne::Tileset::Standard::Tiles::Ds,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111111000000, true),
        RubyCarcassonne::Landmark::Field.new(0b000000111111)))
    should_have_tiles.call(
      2,
      "L-shaped road next to a shielded two-sides city",
      RubyCarcassonne::Tileset::Standard::Tiles::LDs,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b100001000000),
        RubyCarcassonne::Landmark::Road. new(0b010010000000),
        RubyCarcassonne::Landmark::Field.new(0b001100000000),
        RubyCarcassonne::Landmark::City. new(0b000000111111, true)))
    should_have_tiles.call(
      2,
      "shielded H-shaped city",
      RubyCarcassonne::Tileset::Standard::Tiles::Hs,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b111000111000),
        RubyCarcassonne::Landmark::City. new(0b000111000111, true)))
    should_have_tiles.call(
      1,
      "shielded A-shaped city",
      RubyCarcassonne::Tileset::Standard::Tiles::As,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111111000111, true),
        RubyCarcassonne::Landmark::Field.new(0b000000111000)))
    should_have_tiles.call(
      2,
      "shielded A-shaped city with a road",
      RubyCarcassonne::Tileset::Standard::Tiles::AsR,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111111000111, true),
        RubyCarcassonne::Landmark::Field.new(0b000000100000),
        RubyCarcassonne::Landmark::Road. new(0b000000010000),
        RubyCarcassonne::Landmark::Field.new(0b000000001000)))
    should_have_tiles.call(
      1,
      "shielded complete city",
      RubyCarcassonne::Tileset::Standard::Tiles::Os,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City. new(0b111111111111, true)))
    should_have_tiles.call(
      4,
      "simple monastery",
      RubyCarcassonne::Tileset::Standard::Tiles::M,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b111111111111),
        RubyCarcassonne::Landmark::Monastery.new))
    should_have_tiles.call(
      2,
      "monastery with a road",
      RubyCarcassonne::Tileset::Standard::Tiles::MR,
      RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b111111101111),
        RubyCarcassonne::Landmark::Road. new(0b000000010000),
        RubyCarcassonne::Landmark::Monastery.new))

    context("instances") {
      setup {
        @tilesets = (0..9).map { RubyCarcassonne::Tileset::Standard.new }
      }
      should("always pick the IC tile as first tile") {
        @tilesets.each { |t|
          assert_equal RubyCarcassonne::Tileset::Standard::Tiles::IC.generate, t.picked }
      }
      context("with 10 tiles picked") {
        setup {
          @tiles_picked = @tilesets.map { |t| (0..9).map { t.pick } }
        }
        should("not have pick the same sequence twice") {
          assert !(0..@tiles_picked.length.pred.pred).
            any? { |i| (i.next..@tiles_picked.length.pred).
              any? { |j| @tiles_picked[i] == @tiles_picked[j] } }
        }
      }
    }
    context("instance") {
      setup {
        @tileset = RubyCarcassonne::Tileset::Standard.new
      }
      should("thrash previous picked tile when picking and keep the tile picked until next pick") {
        (0..9).each {
          tiles = @tileset.to_a
          picked = @tileset.picked
          pick = @tileset.pick
          assert_equal tiles - [picked], @tileset.to_a
          assert_equal pick, @tileset.picked
        }
      }
      should("indicate the number of remaining tiles") {
        assert_equal 72, @tileset.length
        (0..9).each { |i| @tileset.pick; assert_equal 71 - i, @tileset.length }
      }
    }
  }
end
