require "rspec"
# require "../lib/person"
require "../lib/server"
require "../lib/client"
require "../lib/turn"

describe("#Turn") do
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

  def set_up_turn
    make_clients_join(3)
    person = server.lobby[0]
    person.player.take_cards([Card.new("7", "D"), Card.new("3", "H")])
    Turn.new(person)
  end

  it "has a person who belongs to it" do
    turn = set_up_turn
    expect(turn.person.name).to eq "Mary"
  end

  context "#pick_card" do
    it "shows person their hand and asks what card they want to ask for" do
      turn = set_up_turn
      turn.pick_card
      result = clients[0].get_input
      expect(result.include?("7 of D")).to eq true
      expect(result.include?("3 of H")).to eq true
    end

    it "returns the card object asked for" do
    end
  end

  context "#pick_person" do
    it "shows the person the other players and asks what person they want to ask" do
    end

    it "returns the person object asked for" do
    end
  end

  # context "#show_results" do
  #   it "puts the player and card that were requested" do
  #     make_clients_join(3)
  #     result = clients[1].get_input
  #     expect(result.include?("Joe asked Mary for a 7")).to eq true
  #   end

  #   it "puts number of cards transferred" do
  #   end

  #   it "puts number of books placed by person" do
  #   end
  # end
end
