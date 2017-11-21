class MarsPlateau
  attr_accessor :rovers
  attr_reader :max_x, :max_y

  def initialize(max_x,max_y)
    @max_x = max_x.to_i
    @max_y = max_y.to_i

    throw "Invalid plateau size [#{max_x}, #{max_y}]" if @max_y <= 0 || @max_x <=0
  end
end