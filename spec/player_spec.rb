require "rspec"
require "../lib/player"
require "../lib/card"

describe("#player") do
  let(:player) { Player.new() }

  # before(:each) do
  #   player = Player.new()
  # end

  it "should have an empty hand made" do
    expect(player.hand.length).to eq 0
  end

  it "can take a card and add it to hand" do
    card = Card.new("2", "S")
    player.take_cards([card])
    expect(player.hand.include?(card)).to eq true
  end

  it "can take two cards and add them to hand" do
    card1 = Card.new("2", "S")
    card2 = Card.new("8", "D")
    player.take_cards([card1, card2])
    expect(player.hand.length).to eq 2
  end
end
