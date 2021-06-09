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
end
