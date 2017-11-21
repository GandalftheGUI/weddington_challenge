require_relative "../classes/rover"
require_relative "../classes/mars_plateau"
require "test/unit"

class RoverTests < Test::Unit::TestCase

  def test_turn
    @plateau = MarsPlateau.new(10,20)
    rover = Rover.new(5, 5, 'N', @plateau)
    rover.turn('L')
    assert_equal(rover.direction, 'W')
    rover.turn('L')
    assert_equal(rover.direction, 'S')
    rover.turn('L')
    assert_equal(rover.direction, 'E')
    rover.turn('L')
    assert_equal(rover.direction, 'N')

    rover = Rover.new(5, 5, 'N', @plateau)
    rover.turn('R')
    assert_equal(rover.direction, 'E')
    rover.turn('R')
    assert_equal(rover.direction, 'S')
    rover.turn('R')
    assert_equal(rover.direction, 'W')
    rover.turn('R')
    assert_equal(rover.direction, 'N')
  end

  def test_move
    @plateau = MarsPlateau.new(10,20)
    test_input = [
      ['N', [5, 6]], 
      ['E', [6, 5]], 
      ['S', [5, 4]], 
      ['W', [4, 5]],
    ]

    test_input.each do |input|
      rover = Rover.new(5, 5, input[0], @plateau)
      asserted_x = input[1][0]
      asserted_y = input[1][1]

      rover.move
      assert_equal(rover.x_pos, asserted_x)
      assert_equal(rover.y_pos, asserted_y)
    end
  end
end