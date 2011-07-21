require_relative '../helper'

class LandmarkMonasteryTest < Test::Unit::TestCase
  context("Creating a monastery") {
    should('be ok without sides') {
      assert_nothing_raised {
        RubyCarcassonne::Landmark::Monastery.new }
    }
    should('not be ok with sides') {
      [ 0b100000000000,
        0b000010000000,
        0b010000101001
      ].each { |settings|
        assert_raise(RubyCarcassonne::Landmark::Monastery::SideNumberError) {
          RubyCarcassonne::Landmark::Monastery.new(settings) }
      }
    }
  }
end
