class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other_card)
    other_card.rank == rank
  end

  def show
    "#{rank} of #{suit}"
  end
end
