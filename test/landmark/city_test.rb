require_relative '../helper'

class LandmarkCityTest < Test::Unit::TestCase
  context("A valid city") {
    should("cover straight edges whole") {
      [ 0b000111000000,
        0b111000111000,
        0b111000111111,
        0b111111111111
      ].each { |settings|
        assert_nothing_raised { RubyCarcassonne::Landmark::City.new(settings) } }
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
        assert_raise(RubyCarcassonne::Landmark::City::SidesCoherenceError) { RubyCarcassonne::Landmark::City.new(settings) } }
    }
  }
  context("A city with no walls") {
    should("not exist") {
      assert_raise(RubyCarcassonne::Landmark::City::NoSidesError) { RubyCarcassonne::Landmark::City.new(0b000000000000) }
    }
  }
  context("A valid city with a shield") {
    [ 0b111000000000,
      0b000111111000,
      0b111000111000
    ].each { |settings|
      setup {
        @first_city = RubyCarcassonne::Landmark::City.new(settings, true)
        @other_city = RubyCarcassonne::Landmark::City.new(settings)
        @identical_city = RubyCarcassonne::Landmark::City.new(settings, true)
        @other_identical_city = RubyCarcassonne::Landmark::City.new(settings)
      }
      should("show a shield whereas other cities show none") {
        assert @first_city.shield?
        assert !@other_city.shield?
      }
      should("be different from another city with the same sides but without the shield") {
        assert @first_city != @other_city
        assert @first_city == @identical_city
        assert @other_city == @other_identical_city
      }
    }
  }
end
