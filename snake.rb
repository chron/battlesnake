class Snake
  attr_reader :id, :name, :health, :body, :board

  def initialize(json, board)
    @board = board
    @id = json['id']
    @name = json['name']
    @health = json['health']
    @body = json['body'].map { |body_json| Point.from_json(body_json, board) }
  end

  def head
    body.first
  end
end
