require "rspec"
require "../lib/server"
require "../lib/client"

describe("#Server") do
  let!(:clients) { [] }
  let!(:server) { Server.new() }

  after(:each) do
    clients.each do |client|
      client.close
    end
    server.close
  end

  context "#client_to_person" do
    it "a person is made from a client and a name" do
      person = server.client_to_person(0, "Mary")
      expect(person.name).to eq "Mary"
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
      socket = server.accept_client
      expect(server.lobby.length).to eq 1
    end

    it "server lobby has people in it" do
      client = Client.new()
      clients.push(client)
      socket = server.accept_client
      expect(server.lobby[0].name).to eq "Mary"
    end
  end
end
