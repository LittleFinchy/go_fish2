require_relative "client"

address = "localhost"
port = 3335

client = Client.new(address, port)

while true
  server_message = ""
  while server_message == ""
    server_message = client.get_input
  end
  puts(server_message)
  if server_message.include?(":")
    client.set_output(gets.chomp)
  end
end
