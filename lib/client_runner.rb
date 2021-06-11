require_relative "client"

address = "localhost"
port = 3335

client = Client.new(address, port)

while true
  message = ""
  while message == ""
    message = client.get_input
  end
  puts message
  client.set_output(gets.chomp)
end
