require "rspec"
require "../lib/game"

describe("#Game") do
  let!(:game) { Game.new([Person.new(nil, "Stephen"), Person.new(nil, "Joe"), Person.new(nil, "Mary")]) }

  it "should have a group of people" do
    expect(game.people.length).to eq 3
    expect(game.people[0].name).to eq "Stephen"
  end

  context "#winner" do
    it "returns nil if the game has not ended" do
      game.people[0].player.take_cards([Card.new("5", "D")])
      expect(game.winner).to eq nil
    end

    it "returns player with most books if game is over" do
      book = ["H", "C", "D", "S"].map { |suit| Card.new("2", suit) }
      game.people[0].player.take_cards(book)
      expect(game.winner.name).to eq "Stephen"
    end
  end
end
