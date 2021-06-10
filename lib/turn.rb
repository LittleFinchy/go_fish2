class Turn
  attr_reader :server, :person

  def initialize(server, person)
    @server = server
    @person = person
  end

  def play
  end

  def pick_card
    message = "Pick a card: (type the number next to the card)\n"
    person.player.hand.each_with_index do |card, i|
      message += "#{i + 1}: #{card.show}\n"
    end
    server.set_output(person.client, message)
    card_picked = person.player.hand[server.get_input(person.client).to_i - 1]
  end

  def pick_person
  end

  def show_results
  end
end
