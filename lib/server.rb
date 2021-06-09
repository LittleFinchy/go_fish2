require_relative "person"

class Server
  attr_reader :server, :lobby

  def initialize(port = 3335)
    @server = TCPServer.new(port)
    @lobby = []
  end

  def accept_client
    client = server.accept_nonblock
    person = client_to_person(client, 0)
    lobby.push(person)
  rescue IO::WaitReadable #, Errno::EINTR
    "No Clients"
  end

  def client_to_person(client, name)
    Person.new(client)
  end

  def close
    server.close
  end
end
