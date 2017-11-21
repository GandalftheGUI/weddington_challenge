class Rover
  NORTH = "N"
  SOUTH = "S"
  EAST = "E"
  WEST = "W"
  ABSOLUTE_DIRECTIONS = [NORTH, EAST, SOUTH, WEST]

  LEFT = "L"
  RIGHT = "R"
  RELATIVE_DIRECTIONS = [LEFT, RIGHT]

  MOVEMENT_VECTORS = {
    NORTH => [0, 1], 
    EAST => [1, 0],
    SOUTH => [0, -1],
    WEST => [-1, 0],
  }

  attr_reader :x_pos, :y_pos, :direction, :mars_plateau

  def initialize(x_pos, y_pos, direction, mars_plateau)
    @x_pos = x_pos.to_i
    @y_pos = y_pos.to_i
    @mars_plateau = mars_plateau

    throw "fell off plateau, position: [#{@x_pos}, #{@y_pos}]" if @x_pos < 0 || @y_pos < 0
    throw "fell off plateau, position: [#{@x_pos}, #{@y_pos}]" if @x_pos > @mars_plateau.max_x || @y_pos > @mars_plateau.max_y
    throw "bad absolute direction: '#{direction}'" unless ABSOLUTE_DIRECTIONS.include?(direction)
    
    @direction = direction
  end

  #only moves one space at a time no need for input
  def move
    x_mov, y_mov = MOVEMENT_VECTORS[@direction]

    #add vector to current position
    @x_pos += x_mov
    @y_pos += y_mov

    throw "fell off plateau, position: [#{@x_pos}, #{@y_pos}]" if @x_pos < 0 || @y_pos < 0
    throw "fell off plateau, position: [#{@x_pos}, #{@y_pos}]" if @x_pos > @mars_plateau.max_x || @y_pos > @mars_plateau.max_y

    [@x_pos, @y_pos]
  end

  def turn(relative_direction)
    throw "bad relative direction: '#{relative_direction}'" unless RELATIVE_DIRECTIONS.include?(relative_direction)
    current_index = ABSOLUTE_DIRECTIONS.index(@direction)

    if relative_direction == LEFT
      #move counter-clockwise on the compass rose
      current_index -= 1
      #wrap back around if we reach the beginning of the directions array
      current_index = 3 if current_index < 0
    else # relative_direction == RIGHT
      #move clockwise on the compass rose
      current_index += 1
      #wrap back around if we reach the end of the directions array
      current_index = 0 if current_index > 3
    end

    @direction = ABSOLUTE_DIRECTIONS[current_index]
  end

  def position_readout
    "#{@x_pos} #{@y_pos} #{@direction}"
  end
end
