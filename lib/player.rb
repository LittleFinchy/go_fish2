class Player
  attr_accessor :hand, :name

  def initialize(name, hand = [])
    @name = name
    @hand = hand
  end

  def take_cards(cards)
    self.hand.concat(cards)
  end

  def remove_cards(rank)
    cards_taken = hand.select { |card| card.rank == rank }
    self.hand -= cards_taken
    cards_taken
  end
end
