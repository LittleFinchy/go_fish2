require "socket"
require_relative "person"
require_relative "game"

class Server
  attr_reader :server, :lobby, :games

  def initialize(port = 3335)
    @server = TCPServer.new(port)
    @lobby = []
    @games = []
  end

  def accept_client
    client = server.accept_nonblock
    name = welcome_get_name(client)
    person = Person.new(client, name)
    lobby.push(person)
  rescue IO::WaitReadable #, Errno::EINTR
    "No Clients"
  end

  def create_game_if_possible
    if lobby.length == 3
      game = Game.new(server, lobby.shift(3))
      @games.push(game)
      game
    end
  end

  def welcome_get_name(client, message = "")
    set_output(client, "Welcome, enter your name: ")
    while message == ""
      message = get_input(client)
    end
    message
  end

  def set_output(client, message)
    client.puts message
  end

  def get_input(client)
    sleep(0.1)
    client.read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def close
    server.close
  end
end
