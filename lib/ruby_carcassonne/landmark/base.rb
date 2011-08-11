module RubyCarcassonne::Landmark
  class Base
    DIRECTIONS = [
      :west,
      :south,
      :east,
      :north ]

    SIDES = (0..DIRECTIONS.length.pred).
      inject([]) { |r, i|
        p = DIRECTIONS[i.pred % DIRECTIONS.length]
        d = DIRECTIONS[i]
        n = DIRECTIONS[i.next % DIRECTIONS.length]
        r << :"#{d}_#{p}" << d << :"#{d}_#{n}" }

    CONTACTS = SIDES.inject({}) { |r, k| r.tap { r[k] = 1 << r.length } }

    SIDE_STEP = DIRECTIONS.inject({}) { |r, k| r.tap { r[k] = r.length * 3 } }

    SIDE_MASK = DIRECTIONS.inject({}) { |r, k| r.tap { r[k] = 0b111 << (r.length * 3) } }

    OPPOSITE = (0..DIRECTIONS.length.pred).
      inject({}) { |r, i|
        r.tap {
          c = i * 3 + 1
          o = (c + SIDES.length / 2) % SIDES.length
          r[SIDES[c.pred]] = SIDES[o.next]
          r[SIDES[c]]      = SIDES[o]
          r[SIDES[c.next]] = SIDES[o.pred]
        }
      }

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
      (0..2).
        any? { |i| (side & (1 << i)) > 0 && (other_side & (0b100 >> i)) > 0 }
    end

    def == other
      self.class == other.class && @sides == other.sides
    end

    def <=> other
      other.sides <=> @sides
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
