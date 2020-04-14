require_relative './card'
require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './hand'
require_relative './validation'

def create_user
  print 'Insert your name: '
  name = gets.chomp
  User.new(name)
rescue RuntimeError => e
  puts e.message
  retry
end

def create_dealer
  Dealer.new
rescue RuntimeError => e
  puts e.message
  retry
end

def build_deck
  Deck.new
end

user = create_user
dealer = create_dealer
deck = build_deck
user.hand = Hand.new
dealer.hand = Hand.new
p user
p dealer
p deck
