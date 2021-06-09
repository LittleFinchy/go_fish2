require_relative "player"

class Person
  attr_reader :client, :player

  def initialize(client, name = "Mary")
    @client = client
    @player = Player.new(name)
  end

  def name
    player.name
  end
end
