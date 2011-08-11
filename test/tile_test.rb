require_relative 'helper'

class TileTest < Test::Unit::TestCase
  context("A tile with no landmarks") {
    should("be invalid") {
      assert_raise(RubyCarcassonne::Tile::InvalidTileError) { @tile = RubyCarcassonne::Tile.new }
    }
  }
  [ [ RubyCarcassonne::Landmark::Monastery.new ],
    [ RubyCarcassonne::Landmark::Road.new(0b010010) ],
    [ RubyCarcassonne::Landmark::Field.new(0b001111111100) ],
    [ RubyCarcassonne::Landmark::City.new(0b000111111111) ],
    [ RubyCarcassonne::Landmark::Monastery.new,
      RubyCarcassonne::Landmark::Road.new(0b010000010) ],
    [ RubyCarcassonne::Landmark::Field.new(0b111101101101),
      RubyCarcassonne::Landmark::Road.new(0b000010010000) ],
    [ RubyCarcassonne::Landmark::Field.new(0b000000111111),
      RubyCarcassonne::Landmark::City.new(0b000111000000) ],
    [ RubyCarcassonne::Landmark::Monastery.new,
      RubyCarcassonne::Landmark::Field.new(0b101000101000),
      RubyCarcassonne::Landmark::City.new(0b000111000111),
      RubyCarcassonne::Landmark::Road.new(0b010000000000) ]
  ].each { |landmarks|
    context("A tile with landmarks not covering all its sides") {
      should("be invalid too") {
        assert_raise(RubyCarcassonne::Tile::InvalidTileError) { RubyCarcassonne::Tile.new(*landmarks) }
      }
    }
  }
  [ [ RubyCarcassonne::Landmark::Field.new(0b111111111111),
      RubyCarcassonne::Landmark::Road.new(0b010000000000) ],
    [ RubyCarcassonne::Landmark::Field.new(0b111111000111),
      RubyCarcassonne::Landmark::City.new(0b111000111000), ],
    [ RubyCarcassonne::Landmark::Field.new(0b100000000001),
      RubyCarcassonne::Landmark::Field.new(0b001100000000),
      RubyCarcassonne::Landmark::Field.new(0b000001111100),
      RubyCarcassonne::Landmark::Road.new(0b010000000010),
      RubyCarcassonne::Landmark::Road.new(0b000010000010) ],
  ].each { |landmarks|
    context("Tiles with landmarks overlapping on sides") {
      should("also be invalid") {
        assert_raise(RubyCarcassonne::Tile::InvalidTileError) { RubyCarcassonne::Tile.new(*landmarks) }
      }
    }
  }
  [ lambda {
      [ RubyCarcassonne::Landmark::Field.new(0b101111101111),
        RubyCarcassonne::Landmark::Road.new(0b010000010000) ] },
    lambda {
      [ RubyCarcassonne::Landmark::Monastery.new,
        RubyCarcassonne::Landmark::Field.new(0b111111111111) ] },
    lambda {
      [ RubyCarcassonne::Landmark::City.new(0b111111000000),
        RubyCarcassonne::Landmark::Field.new(0b000000111111) ] },
    lambda {
      [ RubyCarcassonne::Landmark::Field.new(0b100000001111),
        RubyCarcassonne::Landmark::Field.new(0b001111100000),
        RubyCarcassonne::Landmark::Road.new(0b010000010000) ] },
    lambda {
      [ RubyCarcassonne::Landmark::Monastery.new,
        RubyCarcassonne::Landmark::City.new(0b111000000000),
        RubyCarcassonne::Landmark::City.new(0b000111000000),
        RubyCarcassonne::Landmark::Field.new(0b000000111111) ] },
    lambda {
      [ RubyCarcassonne::Landmark::City.new(0b111111000000),
        RubyCarcassonne::Landmark::Field.new(0b000000100001),
        RubyCarcassonne::Landmark::Field.new(0b000000001100),
        RubyCarcassonne::Landmark::Road.new(0b000000010010) ] },
    lambda {
      [ RubyCarcassonne::Landmark::Field.new(0b100000000001),
        RubyCarcassonne::Landmark::Field.new(0b001100000000),
        RubyCarcassonne::Landmark::Field.new(0b000001111100),
        RubyCarcassonne::Landmark::Road.new(0b010000000000),
        RubyCarcassonne::Landmark::Road.new(0b000010000000),
        RubyCarcassonne::Landmark::Road.new(0b000000000010) ] }
  ].each { |blueprints|
    context("A proper tile") {
      setup {
        @landmarks = blueprints.call
        @tile = RubyCarcassonne::Tile.new(*@landmarks)
      }
      should('hold all landmarks properly encased') {
        assert_equal @landmarks.length, @tile.landmarks.length
        @landmarks.each { |landmark| assert @tile.landmarks.include?(landmark) }
      }
      { :clockwise => "clockwise rotation",
        :counterclockwise => "counterclockwise rotation",
        :back => "u-turn"
      }.each { |method, name|
        context("doing a #{name}") {
          setup {
            @rotated_tile = @tile.send(method)
          }
          should('have rotated all its landmarks') {
            assert_equal @tile.landmarks.length, @rotated_tile.landmarks.length
            @tile.landmarks.each { |landmark|
              assert @rotated_tile.landmarks.include?(landmark.send(method))
            }
          }
        }
      }
    }
  }
  context("Two tiles with identical landmarks") {
    setup {
      @first_tile = RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::Field.new(0b111000111111),
        RubyCarcassonne::Landmark::City.new(0b000111000000))
      @other_tile = RubyCarcassonne::Tile.new(
        RubyCarcassonne::Landmark::City.new(0b000111000000),
        RubyCarcassonne::Landmark::Field.new(0b111000111111))
    }
    should("be equal") {
      assert_equal @first_tile, @other_tile
    }
    should("not be the same instance") {
      assert !@first_tile.equal?(@other_tile)
    }
  }
  context("Connectable tiles") {
    setup {
      @x  = RubyCarcassonne::Tileset::Standard::Tiles::X.generate
      @ic = RubyCarcassonne::Tileset::Standard::Tiles::IC.generate
      @ld = RubyCarcassonne::Tileset::Standard::Tiles::LD.generate
      @mr = RubyCarcassonne::Tileset::Standard::Tiles::MR.generate
      @hs = RubyCarcassonne::Tileset::Standard::Tiles::Hs.generate
      @as = RubyCarcassonne::Tileset::Standard::Tiles::As.generate
    }
    should("connect where they may") {
      assert @x. connects?(@ic, :north)
      assert @x. connects?(@ic, :south)
      assert @x. connects?(@ld, :south)
      assert @x. connects?(@ld, :west)
      assert @x. connects?(@mr, :north)
      assert @ic.connects?(@ld, :south)
      assert @ic.connects?(@ld, :east)
      assert @ic.connects?(@mr, :north)
      assert @ic.connects?(@mr, :west)
      assert @ld.connects?(@mr, :north)
      assert @ld.connects?(@hs, :west)
      assert @ld.connects?(@as, :south)
      assert @ld.connects?(@as, :west)
    }
    should("not connect where they may not") {
      assert !@x. connects?(@ic, :east)
      assert !@x. connects?(@ic, :west)
      assert !@x. connects?(@ld, :north)
      assert !@x. connects?(@ld, :east)
      assert !@x. connects?(@mr, :east)
      assert !@x. connects?(@mr, :south)
      assert !@x. connects?(@mr, :west)
      assert !@ic.connects?(@ld, :north)
      assert !@ic.connects?(@ld, :west)
      assert !@ic.connects?(@mr, :east)
      assert !@ic.connects?(@mr, :south)
      assert !@ld.connects?(@mr, :east)
      assert !@ld.connects?(@mr, :south)
      assert !@ld.connects?(@mr, :west)
      assert !@ld.connects?(@hs, :north)
      assert !@ld.connects?(@hs, :east)
      assert !@ld.connects?(@hs, :south)
      assert !@ld.connects?(@as, :east)
      assert !@ld.connects?(@as, :north)
    }
  }
end
