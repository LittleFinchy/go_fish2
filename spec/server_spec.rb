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
