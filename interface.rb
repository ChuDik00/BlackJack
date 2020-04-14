require_relative './card'
require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './validation'

def create_user
  print 'Insert your name: '
  name = gets.chomp
  user = User.new(name)
  p user
rescue RuntimeError => e
  puts e.message
  retry
end

def create_dealer
  dealer = Dealer.new
  p dealer
rescue RuntimeError => e
  puts e.message
  retry
endcreate

def build_deck
  deck = Deck.new
  p deck
end
create_user
create_dealercreate
build_deck
