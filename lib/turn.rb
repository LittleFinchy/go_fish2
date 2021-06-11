class Turn
  attr_reader :server, :person, :people, :deck

  def initialize(server, person, people, deck)
    @server = server
    @person = person
    @people = people
  end

  def play
    card_picked, person_picked = get_picks
    cards_won = person.player.ask(person_picked.player, card_picked)
    results = build_results(card_picked, person_picked, cards_won)
    people.each { |person| person.client.puts results }
    if cards_won.length > 0
      play
    end
  end

  def get_picks
    card_picked = pick_card
    person_picked = pick_person
    [card_picked, person_picked]
  end

  def pick_card
    message = "Pick a card: (type the number next to the card)\n"
    person.player.hand.each_with_index { |card, i| message += "#{i + 1}: #{card.show}\n" }
    server.set_output(person.client, message)
    answer = get_answer
    person.player.hand[answer.to_i - 1]
  end

  def pick_person
    message = "Pick a person: (type the number next to their name)\n"
    others = people - [person]
    others.each_with_index { |person, i| message += "#{i + 1}: #{person.name}\n" }
    server.set_output(person.client, message)
    answer = get_answer
    others[answer.to_i - 1]
  end

  def get_answer
    answer = ""
    while answer == ""
      answer = server.get_input(person.client)
    end
    answer
  end

  def build_results(card_picked, person_picked, cards_won)
    results = ""
    if cards_won.length > 0
      results += "#{person.name} took #{cards_won.length} #{card_picked.rank}s from #{person_picked.name}"
    else
      results += "Go Fish! #{person.name} asked #{person_picked.name} for a #{card_picked.rank}"
    end
    results
  end
end
