require_relative 'helper'

class TileTest < Test::Unit::TestCase
  context("Tiles with no landmarks") {
    should("be invalid") {
      assert_raise(Tile::InvalidTileError) {
        @tile = Tile.new }
    }
  }
  context("Tiles with landmarks not covering all sides") {
    should("be invalid too") {
      [ [ Monastery.new ],
        [ Road.new(0b010010) ],
        [ Field.new(0b001111111100) ],
        [ City.new(0b000111111111) ],
        [ Monastery.new,
          Road.new(0b010000010) ],
        [ Field.new(0b111101101101),
          Road.new(0b000010010000) ],
        [ Field.new(0b000000111111),
          City.new(0b000111000000) ],
        [ Monastery.new,
          Field.new(0b101000101000),
          City.new(0b000111000111),
          Road.new(0b010000000000) ]
      ].each { |landmarks|
        assert_raise(Tile::InvalidTileError) {
          @tile = Tile.new(*landmarks) } }
    }
  }
  context("A valid tile composed only of only a field and a road") {
    setup {
      @landmarks = [
        Field.new(0b101111101111),
        Road.new(0b010000010000)]
      @tile = Tile.new(*@landmarks)
    }
    should('show its two landmarks (and only them)') {
      assert_equal @landmarks.length, @tile.landmarks.length
      @landmarks.each { |landmark| assert @tile.landmarks.include?(landmark) }
    }
  }
end
