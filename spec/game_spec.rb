require "rspec"
require "../lib/game"

describe("#Game") do
  it "should hold a client" do
    person = Person.new(0, "Stephen")
    expect(person.client).to eq 0
  end

end
