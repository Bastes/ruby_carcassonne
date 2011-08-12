module RubyCarcassonne::Tileset
  class Standard
    module Tiles
      class L < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b100001111111),
            RubyCarcassonne::Landmark::Road. new(0b010010000000),
            RubyCarcassonne::Landmark::Field.new(0b001100000000))
        end
      end
      class I < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b100000001111),
            RubyCarcassonne::Landmark::Road. new(0b010000010000),
            RubyCarcassonne::Landmark::Field.new(0b001111100000))
        end
      end
      class T < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b111100000001),
            RubyCarcassonne::Landmark::Road. new(0b000010000000),
            RubyCarcassonne::Landmark::Field.new(0b000001100000),
            RubyCarcassonne::Landmark::Road. new(0b000000010000),
            RubyCarcassonne::Landmark::Field.new(0b000000001100),
            RubyCarcassonne::Landmark::Road. new(0b000000000010))
        end
      end
      class X < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b100000000001),
            RubyCarcassonne::Landmark::Road. new(0b010000000000),
            RubyCarcassonne::Landmark::Field.new(0b001100000000),
            RubyCarcassonne::Landmark::Road. new(0b000010000000),
            RubyCarcassonne::Landmark::Field.new(0b000001100000),
            RubyCarcassonne::Landmark::Road. new(0b000000010000),
            RubyCarcassonne::Landmark::Field.new(0b000000001100),
            RubyCarcassonne::Landmark::Road. new(0b000000000010))
        end
      end
      class C < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b111000111111),
            RubyCarcassonne::Landmark::City. new(0b000111000000))
        end
      end
      class LC < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b100001000111),
            RubyCarcassonne::Landmark::Road. new(0b010010000000),
            RubyCarcassonne::Landmark::Field.new(0b001100000000),
            RubyCarcassonne::Landmark::City. new(0b000000111000))
        end
      end
      class IC < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b100000001111),
            RubyCarcassonne::Landmark::Road. new(0b010000010000),
            RubyCarcassonne::Landmark::Field.new(0b001000100000),
            RubyCarcassonne::Landmark::City. new(0b000111000000))
        end
      end
      class CL < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111000000000),
            RubyCarcassonne::Landmark::Field.new(0b000100001111),
            RubyCarcassonne::Landmark::Road. new(0b000010010000),
            RubyCarcassonne::Landmark::Field.new(0b000001100000))
        end
      end
      class CT < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111000000000),
            RubyCarcassonne::Landmark::Field.new(0b000100000001),
            RubyCarcassonne::Landmark::Road. new(0b000010000000),
            RubyCarcassonne::Landmark::Field.new(0b000001100000),
            RubyCarcassonne::Landmark::Road. new(0b000000010000),
            RubyCarcassonne::Landmark::Field.new(0b000000001100),
            RubyCarcassonne::Landmark::Road. new(0b000000000010))
        end
      end
      class D < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111111000000),
            RubyCarcassonne::Landmark::Field.new(0b000000111111))
        end
      end
      class LD < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b100001000000),
            RubyCarcassonne::Landmark::Road. new(0b010010000000),
            RubyCarcassonne::Landmark::Field.new(0b001100000000),
            RubyCarcassonne::Landmark::City. new(0b000000111111))
        end
      end
      class H < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b111000111000),
            RubyCarcassonne::Landmark::City. new(0b000111000111))
        end
      end
      class A < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111111000111),
            RubyCarcassonne::Landmark::Field.new(0b000000111000))
        end
      end
      class AR < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111111000111),
            RubyCarcassonne::Landmark::Field.new(0b000000100000),
            RubyCarcassonne::Landmark::Road. new(0b000000010000),
            RubyCarcassonne::Landmark::Field.new(0b000000001000))
        end
      end
      class CC < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111000000000),
            RubyCarcassonne::Landmark::City. new(0b000111000000),
            RubyCarcassonne::Landmark::Field.new(0b000000111111))
        end
      end
      class CFC < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111000000000),
            RubyCarcassonne::Landmark::Field.new(0b000111000111),
            RubyCarcassonne::Landmark::City. new(0b000000111000))
        end
      end
      class Ds < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111111000000, true),
            RubyCarcassonne::Landmark::Field.new(0b000000111111))
        end
      end
      class LDs < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b100001000000),
            RubyCarcassonne::Landmark::Road. new(0b010010000000),
            RubyCarcassonne::Landmark::Field.new(0b001100000000),
            RubyCarcassonne::Landmark::City. new(0b000000111111, true))
        end
      end
      class Hs < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b111000111000),
            RubyCarcassonne::Landmark::City. new(0b000111000111, true))
        end
      end
      class As < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111111000111, true),
            RubyCarcassonne::Landmark::Field.new(0b000000111000))
        end
      end
      class AsR < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111111000111, true),
            RubyCarcassonne::Landmark::Field.new(0b000000100000),
            RubyCarcassonne::Landmark::Road. new(0b000000010000),
            RubyCarcassonne::Landmark::Field.new(0b000000001000))
        end
      end
      class Os < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::City. new(0b111111111111, true))
        end
      end
      class M < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b111111111111),
            RubyCarcassonne::Landmark::Monastery.new)
        end
      end
      class MR < RubyCarcassonne::Tile
        def self.generate
          self.new(
            RubyCarcassonne::Landmark::Field.new(0b111111101111),
            RubyCarcassonne::Landmark::Road. new(0b000000010000),
            RubyCarcassonne::Landmark::Monastery.new)
        end
      end
    end

    attr_reader :tiles

    def initialize
      @tiles = {
        Tiles::IC => 4,
        Tiles::L => 9,
        Tiles::I => 8,
        Tiles::T => 4,
        Tiles::X => 1,
        Tiles::C => 5,
        Tiles::LC => 3,
        Tiles::CL => 3,
        Tiles::CT => 3,
        Tiles::D => 3,
        Tiles::LD => 3,
        Tiles::H => 1,
        Tiles::A => 3,
        Tiles::AR => 1,
        Tiles::CC => 2,
        Tiles::CFC => 3,
        Tiles::Ds => 2,
        Tiles::LDs => 2,
        Tiles::Hs => 2,
        Tiles::As => 1,
        Tiles::AsR => 2,
        Tiles::Os => 1,
        Tiles::M => 4,
        Tiles::MR => 2
      }.inject([]) { |r, p| r + Array.new(p[1]) { p[0].generate } }
    end

    def each *args, &block
      @tiles.each *args, &block
    end
  end
end
