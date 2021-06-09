require "rspec"
require "../lib/person"
require "../lib/client"

describe("#Person") do
  # let(:server) { TCPServer.new(3335) }
  # let(:client) { Client.new() }

  # after(:each) do
  #   client.close
  #   server.close
  # end

  it "should hold a client" do
    person = Person.new(0, "Stephen")
    expect(person.client).to eq 0
  end

  it "should hold a player" do
    person = Person.new(nil, "Stephen")
    expect(person.player.name).to eq "Stephen"
  end
end
