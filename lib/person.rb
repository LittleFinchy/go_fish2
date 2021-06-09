require_relative "player"

class Person
  attr_reader :client, :player

  def initialize(client, name)
    @client = client
    @player = Player.new(name)
  end
end
