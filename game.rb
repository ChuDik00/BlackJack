# require_relative './card'
require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './hand'

class Game
  def initialize(user, dealer)
    @deck = build_deck
    @user = user
    @user.hand = Hand.new
    @dealer = dealer
    @dealer.hand = Hand.new

    2.times {@user.hand.deal!(@deck)}
    2.times {@dealer.hand.deal!(@deck)}
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


  def start
    #Если 21 очко у игрока или дилера
    #Показать карты на руках пользователя

    #Иначе Если не 21 у обоих, то играть дальше,
    #где выбор ходов пользователя или дилера
    play_game


    #Показать карты на руках дилера
    #Задать статус выигрыш, проигрыш или ничья (для передачи в main.rb)
    #пересчитать баланс с учётом +10$ или -10$
    #возврат статуса
    status
  end

  def play_game

  end
end


# game = Game.new
# p user
# p dealer
# p deck
# p user.hand.cards.size
# p dealer.hand.cards.size
# p deck.cards.size
