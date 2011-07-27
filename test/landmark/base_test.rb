require_relative '../helper'

class LandmarkBaseTest < Test::Unit::TestCase
  context("A nondescript landmark part class") {
    setup {
      @landmark_class = Class.new(Landmark::Base)
    }
    ###########################################################################
    # RAW SIDES CONSERVATION
    [0b0,0b1,0b100000000000,0b10010, 0b101101].each { |sides|
      context("given these sides : #{sides.to_s(2)}") {
        setup {
          @landmark = @landmark_class.new(sides)
        }
        should('show its sides') {
          assert_equal sides, @landmark.sides
        }
      }
    }
    ###########################################################################
    # HUMANLY READABLE CONTACTS
    context("with no sides") {
      setup {
        @landmark = @landmark_class.new(0b0)
      }
      should('have no directions opened') {
        assert_equal false, @landmark.north_west?
        assert_equal false, @landmark.north?
        assert_equal false, @landmark.north_east?
        assert_equal false, @landmark.east_north?
        assert_equal false, @landmark.east?
        assert_equal false, @landmark.east_south?
        assert_equal false, @landmark.south_east?
        assert_equal false, @landmark.south?
        assert_equal false, @landmark.south_west?
        assert_equal false, @landmark.west_south?
        assert_equal false, @landmark.west?
        assert_equal false, @landmark.west_north?
      }
    }
    context("with all sides") {
      setup {
        @landmark = @landmark_class.new(0b111111111111)
      }
      should('have all directions opened') {
        assert_equal true, @landmark.north_west?
        assert_equal true, @landmark.north?
        assert_equal true, @landmark.north_east?
        assert_equal true, @landmark.east_north?
        assert_equal true, @landmark.east?
        assert_equal true, @landmark.east_south?
        assert_equal true, @landmark.south_east?
        assert_equal true, @landmark.south?
        assert_equal true, @landmark.south_west?
        assert_equal true, @landmark.west_south?
        assert_equal true, @landmark.west?
        assert_equal true, @landmark.west_north?
      }
    }
    context("with north and east sides only") {
      setup {
        @landmark = @landmark_class.new(0b010010000000)
      }
      should('have only the north and east sides opened') {
        assert_equal false, @landmark.north_west?
        assert_equal true,  @landmark.north?
        assert_equal false, @landmark.north_east?
        assert_equal false, @landmark.east_north?
        assert_equal true,  @landmark.east?
        assert_equal false, @landmark.east_south?
        assert_equal false, @landmark.south_east?
        assert_equal false, @landmark.south?
        assert_equal false, @landmark.south_west?
        assert_equal false, @landmark.west_south?
        assert_equal false, @landmark.west?
        assert_equal false, @landmark.west_north?
      }
    }
    context("with the whole south and west only") {
      setup {
        @landmark = @landmark_class.new(0b000000111111)
      }
      should('have only the north and east sides opened') {
        assert_equal false, @landmark.north_west?
        assert_equal false, @landmark.north?
        assert_equal false, @landmark.north_east?
        assert_equal false, @landmark.east_north?
        assert_equal false, @landmark.east?
        assert_equal false, @landmark.east_south?
        assert_equal true,  @landmark.south_east?
        assert_equal true,  @landmark.south?
        assert_equal true,  @landmark.south_west?
        assert_equal true,  @landmark.west_south?
        assert_equal true,  @landmark.west?
        assert_equal true,  @landmark.west_north?
      }
    }
    ###########################################################################
    # RAW CONTACT CHECK
    context('with any landmark placement') {
      setup {
        @landmark = @landmark_class.new(0b010010110101)
      }
      should('show all its contacts right') {
        assert_equal false, @landmark.contact?(0b100000000000)
        assert_equal true,  @landmark.contact?(0b010000000000)
        assert_equal false, @landmark.contact?(0b001000000000)
        assert_equal false, @landmark.contact?(0b000100000000)
        assert_equal true,  @landmark.contact?(0b000010000000)
        assert_equal false, @landmark.contact?(0b000001000000)
        assert_equal true,  @landmark.contact?(0b000000100000)
        assert_equal true,  @landmark.contact?(0b000000010000)
        assert_equal false, @landmark.contact?(0b000000001000)
        assert_equal true,  @landmark.contact?(0b000000000100)
        assert_equal false, @landmark.contact?(0b000000000010)
        assert_equal true,  @landmark.contact?(0b000000000001)
      }
    }
    ###########################################################################
    # TRANSFORMATIONS
    context('any landmark placement') {
      setup {
        @landmark = @landmark_class.new(0b110000010001)
      }
      { :clockwise => 0b001110000010,
        :back => 0b010001110000,
        :counterclockwise => 0b000010001110
      }.each { |rotation, new_sides|
        context("rotating #{rotation}") {
          setup {
            @transformed_landmark = @landmark.send(rotation)
          }
          should('show a new landmark with matching sides') {
            assert_equal new_sides, @transformed_landmark.sides
          }
        }
      }
    }
    ###########################################################################
    # LANDMARK CONNECTION
    context("two landmarks matching north-south / east-west") {
      setup {
        @first_landmark = @landmark_class.new(0b101001001101)
        @other_landmark = @landmark_class.new(0b001101101001)
      }
      should("match on each of their sides") {
        assert_equal true, @first_landmark.connects?(@other_landmark, :north)
        assert_equal true, @first_landmark.connects?(@other_landmark, :east)
        assert_equal true, @first_landmark.connects?(@other_landmark, :south)
        assert_equal true, @first_landmark.connects?(@other_landmark, :west)
      }
    }
    context("two landmarks not matching north-south / east-west") {
      setup {
        @first_landmark = @landmark_class.new(0b010111010110)
        @other_landmark = @landmark_class.new(0b110100011011)
      }
      should("match on each of their sides") {
        assert_equal false, @first_landmark.connects?(@other_landmark, :north)
        assert_equal false, @first_landmark.connects?(@other_landmark, :east)
        assert_equal false, @first_landmark.connects?(@other_landmark, :south)
        assert_equal false, @first_landmark.connects?(@other_landmark, :west)
      }
    }
    ###########################################################################
    # COUNTING SIDES
    { 0b000000000000 => 0,
      0b000010000000 => 1,
      0b001000101000 => 3,
      0b101111011011 => 9,
      0b111111111111 => 12
    }.each { |sides, number|
      context("a landmark with #{number} side(s)") {
        setup {
          @landmark = @landmark_class.new(sides)
        }
        should("count #{number} sides") {
          assert_equal number, @landmark.sides_count
        }
      }
    }
    [ 0b000000000000,
      0b000101110001,
      0b101110101100,
      0b111111111111
    ].each { |settings|
      context("two identical landmarks from that same class") {
        setup {
          @first_landmark = @landmark_class.new(settings)
          @other_landmark = @landmark_class.new(settings)
        }
        should("appear equal") {
          assert @first_landmark == @other_landmark
        }
      }
    }
    { 0b000000000000 => 0b100000000000,
      0b000101110001 => 0b101110101101,
      0b101110101100 => 0b010100110101,
      0b111111111111 => 0b111111111110
    }.each { |first_settings, other_settings|
      context("pairs of different landmarks from that same class") {
        setup {
          @first_landmark = @landmark_class.new(first_settings)
          @other_landmark = @landmark_class.new(other_settings)
        }
        should("appear different") {
          assert @first_landmark != @other_landmark
        }
      }
    }
    context("with another nondescript landmark class") {
      setup {
        @other_landmark_class = Class.new(Landmark::Base)
      }
      [ 0b000000000000,
        0b000101110001,
        0b101110101100,
        0b111111111111
      ].each { |settings|
        context("pairs of otherwise identical landmarks from different classes") {
          setup {
            @first_landmark = @landmark_class.new(settings)
            @other_landmark = @other_landmark_class.new(settings)
          }
          should("also appear different") {
            assert @first_landmark != @other_landmark
          }
        }
      }
    }
  }
end
