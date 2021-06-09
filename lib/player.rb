class Player
  attr_accessor :hand

  def initialize(hand = [])
    @hand = hand
  end

  def take_cards(cards)
    self.hand.concat(cards)
  end
end
