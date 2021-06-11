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
    people.reduce(0) { |total, person| total + person.player.books } == 13 #max num of books for a 52 cards deck
  end

  def play_full_game
    start
    until game_is_over
      people.each { |person| play_turn(person) }
    end
    winner
  end

  def play_turn(person)
    turn = Turn.new(server, person, people, deck)
    results = turn.play
    people.each { |person| person.client.puts results }
  end
end
