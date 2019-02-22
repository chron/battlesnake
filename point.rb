class Point
  attr_reader :x, :y, :board

  def self.from_json(json, board)
    new(json['x'], json['y'], board)
  end

  def initialize(x, y, board)
    @x, @y = x, y
    @board = board
  end

  def manhattan_to(other_point)
    (self.x - other_point.x).abs + (self.y - other_point.y).abs
  end

  def ==(other_point)
    self.x == other_point.x && self.y == other_point.y
  end

  def adjacent_points
    [
      Point.new(x + 1, y, board),
      Point.new(x - 1, y, board),
      Point.new(x, y + 1, board),
      Point.new(x, y - 1, board)
    ].reject(&:out_of_bounds?)
  end

  def out_of_bounds?
    x < 0 || y < 0 || x >= board.width || y >= board.height
  end

  def inspect
    "[#{x},#{y}]"
  end
end
