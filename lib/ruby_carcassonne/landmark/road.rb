module RubyCarcassonne::Landmark
  class Road < Base
    class SideNumberError < Exception
    end

    class SidePositionError < Exception
    end

    def initialize(sides)
      super
      raise SideNumberError.new if sides_count == 0 || sides_count > 2
      raise SidePositionError.new unless (sides & 0b101101101101) == 0
    end
  end
end
