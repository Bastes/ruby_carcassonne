require_relative 'helper'

class BoardTest < Test::Unit::TestCase
  context("An empty board") {
    setup {
      @board = RubyCarcassonne::Board.new
    }
    should("have no tiles on") {
      assert @board.tiles.empty?
    }
  }
end
