require_relative 'helper'

class TileTest < Test::Unit::TestCase
  context("A valid tile composed only of only a field and a road") {
    setup {
      @landmarks = [
        Field.new(0b101111101111),
        Road.new(0b010000010000)]
      @tile = Tile.new(*@landmarks)
    }
    should('show its two landmarks (and only them)') {
      assert_equal @landmarks.length, @tile.landmarks.length
      @landmarks.each { |landmark| assert @tile.landmarks.include?(landmark) }
    }
  }
end
