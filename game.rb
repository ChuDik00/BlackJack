require_relative './card'
require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './hand'
require_relative './validation'

class Game
  def initialize
    @deck = build_deck
    @user = create_user
    @user.hand = Hand.new
    @dealer = create_dealer
    @dealer.hand = Hand.new

    2.times {@user.hand.deal!(@deck)}
    2.times {@dealer.hand.deal!(@deck)}
  end

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

  def user_hand
    puts 'Your cards: '
    @user.hand.show_cards
    print 'Your scores: '
    puts @user.hand.count_points
  end

  def dealer_hand
    puts 'Dealer cards: '
    @dealer.hand.show_cards
    print 'Dealer scores: '
    puts @dealer.hand.count_points
  end
end

game = Game.new
game.user_hand
game.dealer_hand
# p user
# p dealer
# p deck
# p user.hand.cards.size
# p dealer.hand.cards.size
# p deck.cards.size
