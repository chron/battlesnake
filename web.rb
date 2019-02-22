require 'sinatra'
require 'json'
require_relative 'point'
require_relative 'snake'
require_relative 'board'

get '/' do
  ''
end

post '/start' do
  body = request.body.read
  json = body ? JSON.parse(body) : {}

  response = { headType: 'smile', tailType: 'fat-rattle', color: '#dc006e' }

  response.to_json
end

post '/move' do
  body = request.body.read
  return '' if body.nil? || body == ''

  begin
    json = body ? JSON.parse(body) : {}
  rescue JSON::ParserError
    raise body.inspect
  end

  board = Board.new(json['board'], json.dig('you', 'id'))

  me = board.me

  options = board.free_spaces_adjacent_to(me.head)
  #puts "Snake at #{me.head.inspect}"
  #puts "Possible moves: #{options}"

  nearest_food = board.food.min_by { |f| me.head.manhattan_to(f) }
  next_space = options.min_by { |s| s.manhattan_to(nearest_food) }

  #puts "Choice: #{next_space.inspect}"

  direction = if next_space.x < me.head.x
    :left
  elsif next_space.x > me.head.x
    :right
  elsif next_space.y < me.head.y
    :up
  else
    :down
  end

  { move: direction }.to_json
end

post '/end' do
  {}.to_json
end

post '/ping' do
  200
end
