class Board
  attr_reader :height, :width, :food, :snakes

  def initialize(json, owner_id)
    @height = json['height']
    @width = json['width']
    @food = json['food'].map { |food_json| Point.from_json(food_json, self) }
    @snakes = json['snakes'].map { |snake_json| Snake.new(snake_json, self) }
    @owner_id = owner_id
  end

  def me
    @snakes.find { |s| s.id == @owner_id }
  end

  def all_cells
    (0..width).flat_map do |x|
      (0..height).map do |y|
        Point.new(x, y, self)
      end
    end
  end

  def occupied_spaces
    snakes.map(&:body).flatten
  end

  def free_spaces_adjacent_to(point)
    point.adjacent_points.reject { |p| occupied_spaces.any? { |c| c == p }}
  end

  def other_snakes
    @snakes.reject { |s| s.id == @owner_id }
  end
end
