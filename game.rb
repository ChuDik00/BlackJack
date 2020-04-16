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
    if @user.hand.count_points.eql?(21) || @dealer.hand.count_points.eql?(21)
      user_hand
    else
      play_game
    end
    dealer_hand
    status = calculate_status
    new_balance(status)
    status
  end

  def calculate_status
    user_points = @user.hand.count_points
    dealer_points = @dealer.hand.count_points
    status = if user_points.eql?(dealer_points) || (user_points > 21 && dealer_points > 21)
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
    if status.positive?
      @user.increase_balance
      @dealer.decrease_balance
    elsif status.negative?
      @user.decrease_balance
      @dealer.increase_balance
    end
  end

  def play_game
    loop do
      user_hand
      break if @user.hand.cards_number.eql?(3)

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
      @dealer.hand.deal!(@deck) if @dealer.hand.count_points <= 17
      break if choice == 3
    end
  end
end
