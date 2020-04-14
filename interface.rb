require_relative './card'
require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './validation'

def create_user
  print 'Insert your name: '
  name = gets.chomp
  username = User.new(name)
  p username
rescue RuntimeError => e
  puts e.message
  retry
end

create_user
