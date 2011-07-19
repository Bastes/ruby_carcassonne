module RubyCarcassonne::Landmark
  class Base
    CONTACTS = [
      :north_west,
      :north,
      :north_east,
      :east_north,
      :east,
      :east_south,
      :south_east,
      :south,
      :south_west,
      :west_south,
      :west,
      :west_north
    ].reverse.inject({}) { |r, k| r.tap { r[k] = 1 << r.length } }

    SIDE_STEP = [
      :north,
      :east,
      :south,
      :west
    ].reverse.inject({}) { |r, k| r.tap { r[k] = r.length * 3 } }

    SIDE_MASK = [
      :north,
      :east,
      :south,
      :west
    ].reverse.inject({}) { |r, k| r.tap { r[k] = 0b111 << (r.length * 3) } }

    OPPOSITE = {
      :north => :south,
      :east => :west,
      :south => :north,
      :west => :east }

    def initialize sides
      @sides = sides
    end

    def sides
      @sides
    end

    def sides_count
      self.class.count_sides(@sides)
    end

    def contact?(mask)
      @sides & mask > 0
    end

    CONTACTS.each { |contact, mask|
      method_name = :"#{contact}?"
      define_method(method_name) {
        contact? mask
      }
    }

    def connects?(other, direction)
      opposite = OPPOSITE[direction]
      side = (sides & SIDE_MASK[direction]) >> SIDE_STEP[direction]
      other_side = (other.sides & SIDE_MASK[opposite]) >> SIDE_STEP[opposite]
      side == other_side
    end

    [:clockwise, :back, :counterclockwise].each do |rotation|
      define_method(rotation) do
        self.class.new(self.class.send(rotation, @sides))
      end
    end

    def self.clockwise(sides)
      ((sides & 0b111) << 9) + ((sides & 0b111111111000) >> 3)
    end

    def self.counterclockwise(sides)
      ((sides & 0b111111111) << 3) + ((sides & 0b111000000000) >> 9)
    end

    def self.back(sides)
      ((sides & 0b111111) << 6) + ((sides & 0b111111000000) >> 6)
    end

    def self.count_sides(byte)
      count = 0
      count += byte & 1 and byte >>= 1 until byte == 0
      count
    end
  end
end
