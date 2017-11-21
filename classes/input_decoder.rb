require_relative "rover"
require_relative "mars_plateau"

class InputDecoder
  def initialize(instructions)
    read_instructions(instructions)
  end

  private

  def read_instructions(instructions)
    rover_location_line = true
    @plateau = nil

    instructions.each_line.with_index do |line, index|
      if index == 0
        #first line: plateau size
        initialize_plateau(line)
        next
      elsif rover_location_line
        proccess_rover_location(line)
      else #movement instruction line
        process_movement(line)
      end

      #flip between location lines and movement instructions lines
      rover_location_line = !rover_location_line
    end
  end

  def initialize_plateau(line)
    max_x, max_y = line.split(" ")
    #plateau size validity checked in mars_plateu class
    @plateau = MarsPlateau.new(max_x, max_y)
    log_output "Created plateau size: [#{@plateau.max_x}, #{@plateau.max_y}]"
  end

  def proccess_rover_location(line)
    log_output "Rover location: #{line}"
    #rover location validity is checked in rover class
    location_array = line.split(" ")
    x_pos, y_pos = location_array
    direction = location_array.last

    @last_rover = Rover.new(x_pos, y_pos, direction, @plateau)
    log_output "Created rover at [#{@last_rover.x_pos}, #{@last_rover.y_pos}] facing: '#{direction}'"
  end

  def process_movement(line)
    throw "No rover present! Instructions out of order?" unless @last_rover

    log_output "Movement instructions: #{line}"

    line.split("").each do |instruction|
      log_output "Executing: '#{instruction}'"
      if instruction == 'M'
        @last_rover.move
      elsif instruction == 'L' || instruction == 'R'
        @last_rover.turn(instruction)
      end
      log_output "New position: #{@last_rover.position_readout}"
    end

    puts @last_rover.position_readout 
  end

  def log_output(output)
    puts(output) if false
  end
end