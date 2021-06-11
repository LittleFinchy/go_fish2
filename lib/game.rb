require_relative "deck"

class Game
  attr_reader :people, :deck

  def initialize(people)
    @people = people
    @deck = Deck.new()
  end

  def start
    5.times do
      people.each do |person|
        person.player.take_cards([deck.deal])
      end
    end
  end

  def winner
    scores = {}
    people.each { |person| scores[person.player.books] = person }
    scores[scores.keys.max]
  end

  def game_is_over
    people.reduce(0) { |total, person| total + person.player.books } == 13
  end

  def play_full_game
    until game_is_over
      people.each { |player| play_turn(player) }
    end
    winner
  end

  def play_turn(player)
  end
end
