require_relative "deck"
require_relative "turn"

class Game
  attr_reader :server, :people, :deck

  def initialize(server, people)
    @server = server
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
    people_with_cards = people.select { |person| person.player.hand.length > 0 }
    people_with_cards.length != 4
  end

  def play_full_game
    start
    until game_is_over
      people_with_cards = people.select { |person| person.player.hand.length > 0 }
      people_with_cards.each { |person| play_turn(person) }
    end
    people.each { |person| person.client.puts "Game Over! #{winner.name} is the winner!" }
  end

  def play_turn(person)
    people_with_cards = people.select { |person| person.player.hand.length > 0 }
    if person.player.hand.length > 0
      turn = Turn.new(server, person, people_with_cards, deck)
      turn.play
    end
  end
end
