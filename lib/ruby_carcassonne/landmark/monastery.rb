module RubyCarcassonne::Landmark
  class Monastery < Base
    class SideNumberError < Exception
    end

    def initialize(sides = 0)
      raise SideNumberError.new unless sides == 0
      super
    end
  end
end
