class Turn
  attr_reader :person

  def initialize(person)
    @person = person
  end

  def play
  end

  def pick_card
    person.player.hand
    person.client.puts("K of D")
  end

  def pick_person
  end

  def show_results
  end
end
