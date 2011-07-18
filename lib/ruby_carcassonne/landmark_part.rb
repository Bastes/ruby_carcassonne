module RubyCarcassonne::LandmarkPart
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

  def initialize sides
    @sides = sides
  end

  def sides
    @sides
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
end
