require_relative "deck"

class Game
  attr_reader :people

  def initialize(people)
    @people = people
    @deck = Deck.new()
  end

  def winner
    if game_is_over
      scores = {}
      people.each { |person| scores[person.player.books] = person }
      scores[scores.keys.max]
    end
  end

  def game_is_over
    players_with_cards = people.select { |person| person.player.hand.length > 0 }
    players_with_cards.empty?
  end

  def play_full_game
  end

  def play_turn
  end
end
