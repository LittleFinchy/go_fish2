require "rspec"
require "../lib/game"

describe("#Game") do
  let!(:game) { Game.new([Person.new(nil, "Stephen"), Person.new(nil, "Joe"), Person.new(nil, "Mary")]) }

  it "should have a group of people" do
    expect(game.people.length).to eq 3
    expect(game.people[0].name).to eq "Stephen"
  end

  context "#start" do
    it "should deal 5 cards to each player" do
      game.start
      player1_hand = game.people[0].player.hand
      player3_hand = game.people[2].player.hand
      expect(player1_hand.length).to eq 5
      expect(player3_hand.length).to eq 5
    end
  end

  context "#game_is_over" do
    it "returns false if the game has not ended" do
      expect(game.game_is_over).to eq false
    end

    it "returns true if 13 books have been played" do
      game.people[0].player.books = 13
      expect(game.game_is_over).to eq true
    end
  end

  context "#winner" do
    it "returns player with most books" do
      book = ["H", "C", "D", "S"].map { |suit| Card.new("2", suit) }
      game.people[0].player.take_cards(book)
      expect(game.winner.name).to eq "Stephen"
    end
  end
end
