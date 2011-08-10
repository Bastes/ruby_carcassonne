require_relative '../helper'

class LandmarkRoadTest < Test::Unit::TestCase
  context("A valid one-sided road") {
    should('be ok') {
      [ 0b010000000000,
        0b000010000000,
        0b000000010000,
        0b000000000010
      ].each { |setting|
        assert_nothing_raised { RubyCarcassonne::Landmark::Road.new(setting) }
      }
    }
  }
  context("A valid two-sided road") {
    should('be ok') {
      [ 0b010010000000,
        0b000010000010,
        0b000010010000,
        0b010000000010
      ].each { |setting|
        assert_nothing_raised { RubyCarcassonne::Landmark::Road.new(setting) }
      }
    }
  }
  context("More than two sided roads") {
    should('not exist') {
      [ 0b010010010000,
        0b010010000010,
        0b010000010010,
        0b000010010010
      ].each { |setting|
        assert_raise(RubyCarcassonne::Landmark::Road::SideNumberError) { RubyCarcassonne::Landmark::Road.new(setting) }
      }
    }
  }
  context("Roads connecting at weird places") {
    should('not exist') {
      [ 0b100000000000,
        0b000001100000,
        0b010100000000,
        0b000000100010
      ].each { |setting|
        assert_raise(RubyCarcassonne::Landmark::Road::SidePositionError) { RubyCarcassonne::Landmark::Road.new(setting) }
      }
    }
  }
end
