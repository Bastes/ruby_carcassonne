require_relative '../helper'

class StandardTilesetTest < Test::Unit::TestCase
  context("The standard tileset") {
    should("exist") {
      assert_nothing_raised { RubyCarcassonne::Tileset::Standard }
    }
  }
end
