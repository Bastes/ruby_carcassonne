require_relative 'helper'

class LandmarkPartTest < Test::Unit::TestCase
  context("A nondescript landmark part class") {
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
  }
end
