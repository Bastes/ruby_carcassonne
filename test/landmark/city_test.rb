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
  # FIXME : test for invalid cities
end
