require "rspec"
require "socket"
require "../lib/client"

describe("#Client") do
  let!(:clients) { [] }
  let!(:server) { TCPServer.new(3335) }

  after(:each) do
    clients.each do |client|
      client.close
    end
    server.close
  end

  context "#get_input" do
    it "should get a message sent from a server" do
      client = Client.new()
      clients.push(client)
      socket = server.accept
      socket.puts "test"
      expect(client.get_input).to eq "test"
    end

    it "should rescue if no message was sent" do
      client = Client.new()
      clients.push(client)
      socket = server.accept
      expect(client.get_input).to eq ""
    end
  end

  context "#get_input" do
    it "should get a message sent from a server" do
      client = Client.new()
      clients.push(client)
      socket = server.accept
      socket.puts "test"
      expect(client.get_input).to eq "test"
    end

    it "should rescue if no message was sent" do
      client = Client.new()
      clients.push(client)
      socket = server.accept
      expect(client.get_input).to eq ""
    end
  end
end
