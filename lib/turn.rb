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
    person.player.ask(person_picked, card_picked)
  end

  def pick_card
    message = "Pick a card: (type the number next to the card)\n"
    person.player.hand.each_with_index { |card, i| message += "#{i + 1}: #{card.show}\n" }
    server.set_output(person.client, message)
    person.player.hand[server.get_input(person.client).to_i - 1]
  end

  def pick_person
    message = "Pick a person: (type the number next to their name)\n"
    others = people - [person]
    others.each_with_index { |person, i| message += "#{i + 1}: #{person.name}\n" }
    server.set_output(person.client, message)
    others[server.get_input(person.client).to_i - 1]
  end

  def show_results
  end
end
