# require_relative './card'
require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './hand'

class Game
  def initialize(user, dealer)
    @deck = Deck.new
    @user = user
    @user.hand = Hand.new
    @dealer = dealer
    @dealer.hand = Hand.new

    2.times {@user.hand.deal!(@deck)}
    2.times {@dealer.hand.deal!(@deck)}
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

  def status
    #Если 21 очко у игрока или дилера
    if @user.hand.count_points.eql?(21) || @dealer.hand.count_points.eql?(21)
      #Показать карты на руках пользователя
      user_hand

      #Иначе Если не 21 у обоих, то играть дальше,
      #где выбор ходов пользователя или дилера
    else
      play_game
    end

    # Показать карты на руках дилера
    dealer_hand
    # Задать статус выигрыш, проигрыш или ничья (для передачи в main.rb)
    status = calculate_status
    # пересчитать баланс с учётом +10$ или -10$
      new_balance(status)
    #возврат статуса
    status
  end

  def calculate_status
    user_points = @user.hand.count_points
    dealer_points = @dealer.hand.count_points
    status = if user_points.eql?(dealer_points)
               0
             elsif user_points.eql?(21)
               1
             elsif user_points > 21
               -1
             elsif user_points > dealer_points
               1
             elsif user_points < dealer_points && dealer_points <= 21
               -1
             elsif user_points < dealer_points && dealer_points > 21
               1
             end
    status
  end

  def new_balance(status)
    # если пользователдь выиграл (status.positive?)
    if status.positive?
      @user.increase_balance
      @dealer.decrease_balance
      # если пользователь проиграл (status.negative?)
    elsif status.negative?
      @user.decrease_balance
      @dealer.increase_balance
    end
  end

  def play_game
    loop do
      # вылететь, если число карт = 3 (луп)
      user_hand
      break if @user.hand.cards_number.eql?(3)

      # для пользователя пропустить ход, взять карту, открыться (break loop)
      puts '1 - Skip'
      puts '2 - Add one card'
      puts '3 - Show cards'
      choice = gets.chomp.to_i
      case choice
      when 1
        puts 'Skipped one deal'
      when 2
        @user.hand.deal!(@deck)
      when 3
        puts 'Show cards'
      else
        puts 'Wrong choice.'
      end
      # для дилера, если очков меньше или = 17 добавить картул
      @dealer.hand.deal!(@deck) if @dealer.hand.count_points <= 17
      break if choice == 3
    end
  end
end


# game = Game.new
# p user
# p dealer
# p deck
# p user.hand.cards.size
# p dealer.hand.cards.size
# p deck.cards.size
