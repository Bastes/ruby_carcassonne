require_relative '../helper'

class LandmarkFieldTest < Test::Unit::TestCase
  context("A valid field") {
    should('be just a valid landmark') {
      [ 0b000000000000,
        0b101111111111,
        0b000000111000,
        0b000111111000,
        0b000111000101,
        0b100000001111,
        0b001100000000,
        0b111111111111
      ].each { |setting|
        assert_nothing_raised { Field.new(setting) } }
    }
  }
end
