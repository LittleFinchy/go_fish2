require_relative "card"

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    build_deck
    cards.shuffle!
  end

  def build_deck
    ["H", "C", "D", "S"].each do |suit|
      ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].each do |rank|
        cards.push(Card.new(rank, suit))
      end
    end
  end

  def cards_left
    cards.length
  end

  def deal
    cards.pop
  end
end
