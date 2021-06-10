require "rspec"
require "../lib/player"
require "../lib/card"

describe("#player") do
  let(:player) { Player.new("Stephen") }

  it "should have an empty hand made" do
    expect(player.hand.length).to eq 0
  end

  it "can take a card and add it to hand" do
    card = Card.new("2", "S")
    player.take_cards([card])
    expect(player.hand.include?(card)).to eq true
  end

  context "#take_cards" do
    it "can take two cards and add them to hand" do
      card1 = Card.new("2", "S")
      card2 = Card.new("8", "D")
      player.take_cards([card1, card2])
      expect(player.hand.length).to eq 2
    end
  end

  context "#remove_cards" do
    it "return and remove cards of a given rank" do
      player.take_cards([Card.new("2", "S"), Card.new("8", "D"), Card.new("8", "H")])
      cards_removed = player.remove_cards("8")
      expect(cards_removed).to eq [Card.new("8", "D"), Card.new("8", "H")]
      expect(player.hand).to eq [Card.new("2", "S")]
    end
  end

  context "#ask" do
    it "return an array of cards from a player that match a rank" do
      player2 = Player.new("Connor", [Card.new("7", "D"), Card.new("5", "D")])
      taken = player.ask(player2, Card.new("7", "D"))
      expect(taken).to eq [Card.new("7", "D")]
    end

    it "adds to hand an array of cards from a player that match a rank" do
      player2 = Player.new("Connor", [Card.new("7", "D"), Card.new("5", "D")])
      player.ask(player2, Card.new("7", "D"))
      expect(player.hand).to eq [Card.new("7", "D")]
    end
  end

  context "#check_for_book" do
    it "increase the books count for a player if they have a book" do
      player.take_cards([Card.new("8", "C"), Card.new("8", "S"), Card.new("2", "S"), Card.new("8", "D"), Card.new("8", "H")])
      expect(player.books).to eq 1
    end

    it "takes the book out of the players hand" do
      player.take_cards([Card.new("8", "C"), Card.new("8", "S"), Card.new("2", "S"), Card.new("8", "D"), Card.new("8", "H")])
      expect(player.hand.length).to eq 1
    end
  end
end
