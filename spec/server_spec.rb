require "rspec"
require "../lib/server"
require "../lib/client"

describe("#Server") do
  let!(:clients) { [] }
  let!(:server) { Server.new() }

  after(:each) do
    clients.each { |client| client.close }
    server.close
  end

  def make_clients_join(num)
    num.times do |x|
      client = Client.new()
      clients.push(client)
      client.set_output(["Mary", "Stephen", "Joe"][x])
      socket = server.accept_client
      client.get_input
    end
  end

  context "#set_output" do
    it "gives the client a message" do
      client = Client.new()
      clients.push(client)
      socket = server.server.accept_nonblock
      server.set_output(socket, "Welcome")
      expect(client.get_input).to eq "Welcome"
    end
  end

  context "#get_input" do
    it "gets a message from a client" do
      client = Client.new()
      clients.push(client)
      socket = server.server.accept_nonblock
      client.set_output "hello"
      message = server.get_input(socket)
      expect(message).to eq "hello"
    end
  end

  context "#accept_client" do
    it "clients can join the server" do
      client = Client.new()
      clients.push(client)
      client.set_output("Mary")
      socket = server.accept_client
      expect(server.lobby.length).to eq 1
    end

    it "server lobby has people in it" do
      client = Client.new()
      clients.push(client)
      client.set_output("Mary")
      socket = server.accept_client
      expect(server.lobby[0].name).to eq "Mary"
    end

    it "server lobby has people in it" do
      make_clients_join(3)
      expect(server.lobby[2].name).to eq "Joe"
    end
  end

  context "#create_game_if_possible" do
    it "does not creates a game if only 2 clients join" do
      make_clients_join(2)
      game = server.create_game_if_possible
      expect(game).to be nil
    end

    it "creates a game if 3 clients join" do
      make_clients_join(3)
      game = server.create_game_if_possible
      expect(game).to_not be nil
    end

    it "moves people from lobby to the game" do
      make_clients_join(3)
      people = server.lobby.dup
      game = server.create_game_if_possible
      expect(server.lobby).to eq []
      expect(game.people).to eq people
    end
  end
end
