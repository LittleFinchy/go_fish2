require "rspec"
require "../lib/person"

describe("#Person") do
  it "should hold a client" do
    person = Person.new(0, "Stephen")
    expect(person.client).to eq 0
  end

  it "should hold a player" do
    person = Person.new(nil, "Stephen")
    expect(person.player.name).to eq "Stephen"
  end
end
