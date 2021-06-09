require "rspec"
require "../lib/deck"

def deal_cards(deck, num)
  cards = []
  num.times do
    cards.push(deck.deal)
  end
  cards
end

describe("#deck") do
  it "should have 52 cards when made" do
    deck = Deck.new()
    expect(deck.cards_left).to eq 52
  end

  it "should deal a card object" do
    deck = Deck.new()
    card = deck.deal
    expect(["H", "C", "D", "S"].include?(card.suit)).to eq true
    expect(deck.cards_left).to eq 51
  end

  it "should shuffle the deck when made" do
    deck = Deck.new()
    cards = deal_cards(deck, 39)
    ranks = []
    cards.each do |card|
      ranks.push(card.suit)
    end
    expect(ranks.uniq.length).to eq 4
  end
end
