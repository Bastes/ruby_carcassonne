require_relative 'helper'

class TileTest < Test::Unit::TestCase
  context("A tile with no landmarks") {
    should("be invalid") {
      assert_raise(Tile::InvalidTileError) { @tile = Tile.new }
    }
  }
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
    context("A tile with landmarks not covering all its sides") {
      should("be invalid too") {
        assert_raise(Tile::InvalidTileError) { Tile.new(*landmarks) }
      }
    }
  }
  [ [ Field.new(0b111111111111),
      Road.new(0b010000000000) ],
    [ Field.new(0b111111000111),
      City.new(0b111000111000), ],
    [ Field.new(0b100000000001),
      Field.new(0b001100000000),
      Field.new(0b000001111100),
      Road.new(0b010000000010),
      Road.new(0b000010000010) ],
  ].each { |landmarks|
    context("Tiles with landmarks overlapping on sides") {
      should("also be invalid") {
        assert_raise(Tile::InvalidTileError) { Tile.new(*landmarks) }
      }
    }
  }
  [ lambda {
      [ Field.new(0b101111101111),
        Road.new(0b010000010000) ] },
    lambda {
      [ Monastery.new,
        Field.new(0b111111111111) ] },
    lambda {
      [ City.new(0b111111000000),
        Field.new(0b000000111111) ] },
    lambda {
      [ Field.new(0b100000001111),
        Field.new(0b001111100000),
        Road.new(0b010000010000) ] },
    lambda {
      [ City.new(0b111000000000),
        City.new(0b000111000000),
        Field.new(0b000000111111) ] },
    lambda {
      [ City.new(0b111111000000),
        Field.new(0b000000100001),
        Field.new(0b000000001100),
        Road.new(0b000000010010) ] },
    lambda {
      [ Field.new(0b100000000001),
        Field.new(0b001100000000),
        Field.new(0b000001111100),
        Road.new(0b010000000000),
        Road.new(0b000010000000),
        Road.new(0b000000000010) ] }
  ].each { |blueprints|
    context("A tile with landmarks covering all the sides") {
      setup {
        @landmarks = blueprints.call
        @tile = Tile.new(*@landmarks)
      }
      should('hold all landmarks properly encased') {
        assert_equal @landmarks.length, @tile.landmarks.length
        @landmarks.each { |landmark| assert @tile.landmarks.include?(landmark) }
      }
    }
  }
end
