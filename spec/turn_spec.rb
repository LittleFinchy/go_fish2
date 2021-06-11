require "rspec"
require "../lib/server"
require "../lib/client"
require "../lib/turn"

describe("#Turn") do
  let!(:clients) { [] }
  let!(:server) { Server.new() }
  let!(:turn) { set_up_turn }
  let!(:person2) { server.lobby[1] }
  let!(:person3) { server.lobby[2] }

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

  def set_up_turn
    make_clients_join(3)
    person = server.lobby[0]
    person.player.take_cards([Card.new("7", "D"), Card.new("3", "H"), Card.new("4", "S")])
    Turn.new(server, person, server.lobby)
  end

  it "has a person who belongs to it" do
    expect(turn.person.name).to eq "Mary"
  end

  context "#pick_card" do
    it "shows person their hand and asks what card they want to ask for" do
      turn.pick_card
      result = clients[0].get_input
      expect(result.include?("Pick a card:")).to eq true
      expect(result.include?("7 of D")).to eq true
      expect(result.include?("3 of H")).to eq true
      expect(result.include?("4 of S")).to eq true
    end

    it "returns the card object asked for" do
      clients[0].set_output("1")
      card = turn.pick_card
      expect(card).to eq Card.new("7", "D")
    end

    it "returns the card object asked for" do
      clients[0].set_output("2")
      card = turn.pick_card
      expect(card).to eq Card.new("3", "H")
    end

    it "returns the card object asked for" do
      clients[0].set_output("3")
      card = turn.pick_card
      expect(card).to eq Card.new("4", "S")
    end
  end

  context "#pick_person" do
    it "shows the person the other people and asks what person they want to ask" do
      turn.pick_person
      result = clients[0].get_input
      expect(result.include?("Stephen")).to eq true
      expect(result.include?("Joe")).to eq true
    end

    it "returns the person object asked for" do
      clients[0].set_output("1")
      pick = turn.pick_person
      expect(pick.name).to eq "Stephen"
    end

    it "returns the person object asked for" do
      clients[0].set_output("2")
      pick = turn.pick_person
      expect(pick.name).to eq "Joe"
    end
  end
end
