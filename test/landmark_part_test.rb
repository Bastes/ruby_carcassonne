require_relative 'helper'

class LandmarkPartTest < Test::Unit::TestCase
  context("A nondescript landmark part class") {
    ###########################################################################
    # RAW SIDES CONSERVATION
    setup {
      @landmark_part_class = Class.new do
        include RubyCarcassonne::LandmarkPart
      end
    }
    [0b0,0b1,0b100000000000,0b10010, 0b101101].each { |sides|
      context("given these sides : #{sides.to_s(2)}") {
        setup {
          @landmark_part = @landmark_part_class.new(sides)
        }
        should('show its sides') {
          assert_equal sides, @landmark_part.sides
        }
      }
    }
    ###########################################################################
    # HUMANLY READABLE CONTACTS
    context("with no sides") {
      setup {
        @landmark_part = @landmark_part_class.new(0b0)
      }
      should('have no directions opened') {
        assert_equal false, @landmark_part.north_west?
        assert_equal false, @landmark_part.north?
        assert_equal false, @landmark_part.north_east?
        assert_equal false, @landmark_part.east_north?
        assert_equal false, @landmark_part.east?
        assert_equal false, @landmark_part.east_south?
        assert_equal false, @landmark_part.south_east?
        assert_equal false, @landmark_part.south?
        assert_equal false, @landmark_part.south_west?
        assert_equal false, @landmark_part.west_south?
        assert_equal false, @landmark_part.west?
        assert_equal false, @landmark_part.west_north?
      }
    }
    context("with all sides") {
      setup {
        @landmark_part = @landmark_part_class.new(0b111111111111)
      }
      should('have all directions opened') {
        assert_equal true, @landmark_part.north_west?
        assert_equal true, @landmark_part.north?
        assert_equal true, @landmark_part.north_east?
        assert_equal true, @landmark_part.east_north?
        assert_equal true, @landmark_part.east?
        assert_equal true, @landmark_part.east_south?
        assert_equal true, @landmark_part.south_east?
        assert_equal true, @landmark_part.south?
        assert_equal true, @landmark_part.south_west?
        assert_equal true, @landmark_part.west_south?
        assert_equal true, @landmark_part.west?
        assert_equal true, @landmark_part.west_north?
      }
    }
    context("with north and east sides only") {
      setup {
        @landmark_part = @landmark_part_class.new(0b010010000000)
      }
      should('have only the north and east sides opened') {
        assert_equal false, @landmark_part.north_west?
        assert_equal true,  @landmark_part.north?
        assert_equal false, @landmark_part.north_east?
        assert_equal false, @landmark_part.east_north?
        assert_equal true,  @landmark_part.east?
        assert_equal false, @landmark_part.east_south?
        assert_equal false, @landmark_part.south_east?
        assert_equal false, @landmark_part.south?
        assert_equal false, @landmark_part.south_west?
        assert_equal false, @landmark_part.west_south?
        assert_equal false, @landmark_part.west?
        assert_equal false, @landmark_part.west_north?
      }
    }
    context("with the whole south and west only") {
      setup {
        @landmark_part = @landmark_part_class.new(0b000000111111)
      }
      should('have only the north and east sides opened') {
        assert_equal false, @landmark_part.north_west?
        assert_equal false, @landmark_part.north?
        assert_equal false, @landmark_part.north_east?
        assert_equal false, @landmark_part.east_north?
        assert_equal false, @landmark_part.east?
        assert_equal false, @landmark_part.east_south?
        assert_equal true,  @landmark_part.south_east?
        assert_equal true,  @landmark_part.south?
        assert_equal true,  @landmark_part.south_west?
        assert_equal true,  @landmark_part.west_south?
        assert_equal true,  @landmark_part.west?
        assert_equal true,  @landmark_part.west_north?
      }
    }
    ###########################################################################
    # RAW CONTACT CHECK
    context('any landmark placement') {
      setup {
        @landmark_part = @landmark_part_class.new(0b010010110101)
      }
      should('show all its contacts right') {
        assert_equal false, @landmark_part.contact?(0b100000000000)
        assert_equal true,  @landmark_part.contact?(0b010000000000)
        assert_equal false, @landmark_part.contact?(0b001000000000)
        assert_equal false, @landmark_part.contact?(0b000100000000)
        assert_equal true,  @landmark_part.contact?(0b000010000000)
        assert_equal false, @landmark_part.contact?(0b000001000000)
        assert_equal true,  @landmark_part.contact?(0b000000100000)
        assert_equal true,  @landmark_part.contact?(0b000000010000)
        assert_equal false, @landmark_part.contact?(0b000000001000)
        assert_equal true,  @landmark_part.contact?(0b000000000100)
        assert_equal false, @landmark_part.contact?(0b000000000010)
        assert_equal true,  @landmark_part.contact?(0b000000000001)
      }
    }
    ###########################################################################
    # TRANSFORMATIONS
    context('any landmark placement') {
      setup {
        @landmark_part = @landmark_part_class.new(0b110000010001)
      }
      { :clockwise => 0b001110000010,
        :back => 0b010001110000,
        :counterclockwise => 0b000010001110
      }.each { |rotation, new_sides|
        context("rotating #{rotation}") {
          setup {
            @transformed_landmark_part = @landmark_part.send(rotation)
          }
          should('show a new landmark with matching sides') {
            assert_equal new_sides, @transformed_landmark_part.sides
          }
        }
      }
    }
  }
end
