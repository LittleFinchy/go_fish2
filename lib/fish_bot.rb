require_relative "client"

address = "localhost"
port = 3335

client = Client.new(address, port)
client.set_output(["BOT", "BOT2", "BOT3", "BOT4", "BOT5"].sample)

while true
  message = ""
  while message == ""
    message = client.get_input
  end
  puts message
  if message.include?("person")
    client.set_output(["1", "2"].sample)
  elsif message.include?("card")
    client.set_output("1")
  end
end
