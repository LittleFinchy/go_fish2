class Client
  attr_reader :socket

  def initialize(address = "localhost", port = 3335)
    @socket = TCPSocket.new(address, port)
  end

  def get_input
    sleep(0.1)
    socket.read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def close
    socket.close
  end
end
