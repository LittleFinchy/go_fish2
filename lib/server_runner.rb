require_relative "server"

server = Server.new()

while true
  server.accept_client
  game = server.create_game_if_possible(server)
  if game
    Thread.new(game) { |game| game.play_full_game }
  end
end
