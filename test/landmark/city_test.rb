require_relative '../helper'

class LandmarkCityTest < Test::Unit::TestCase
  context("A valid city") {
    should("cover straight edges whole") {
      [ 0b000111000000,
        0b111000111000,
        0b111000111111,
        0b111111111111
      ].each { |settings|
        assert_nothing_raised {
          RubyCarcassonne::Landmark::City.new(settings) }
      }
    }
  }
  context("A city with holes in its walls") {
    should("be invalid") {
      [ 0b101000000000,
        0b000001000000,
        0b000000111110,
        0b111100111001,
        0b000000100001
      ].each { |settings|
        assert_raise(RubyCarcassonne::Landmark::City::SidesCoherenceError) {
          RubyCarcassonne::Landmark::City.new(settings) }
      }
    }
  }
  context("A city with no walls") {
    should("not exist") {
      assert_raise(RubyCarcassonne::Landmark::City::NoSidesError) {
        RubyCarcassonne::Landmark::City.new(0b000000000000) }
    }
  }
end
