class Turn
  attr_reader :server, :person, :people

  def initialize(server, person, people)
    @server = server
    @person = person
    @people = people
  end

  def play
    card_picked = pick_card
    person_picked = pick_person
    cards_won = person.player.ask(person_picked.player, card_picked)
    show_results(card_picked, person_picked, cards_won)
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

  def show_results(card_picked, person_picked, cards_won)
    results = ""
    if cards_won.length > 0
      results += "#{person.name} took #{cards_won.length} #{card_picked.rank}s from #{person_picked.name}"
    else
      results += "Go Fish! #{person.name} asked #{person_picked.name} for a #{card_picked.rank}"
    end
  end
end
