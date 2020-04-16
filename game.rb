# frozen_string_literal: true

require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './hand'

class Game
  def initialize(user, dealer)
    @deck = Deck.new
    puts "\nShuffle cards and start new game!"
    @user = user
    @user.hand = Hand.new
    @dealer = dealer
    @dealer.hand = Hand.new

    2.times { @user.hand.deal!(@deck) }
    2.times { @dealer.hand.deal!(@deck) }
  end

  def status
    play_game
    dealer_hand
    status = calculate_status
    new_balance(status)
    status
  end

  private

  def user_hand
    puts "\nYour cards: "
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

  # rubocop:disable all
  def calculate_status
    user_points = @user.hand.count_points
    dealer_points = @dealer.hand.count_points
    status = if user_points.eql?(dealer_points) ||
                (user_points > 21 && dealer_points > 21)
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
  # rubocop:enable all

  def new_balance(status)
    if status.positive?
      @user.increase_balance
      @dealer.decrease_balance
    elsif status.negative?
      @user.decrease_balance
      @dealer.increase_balance
    end
  end

  def first_step_choice(choice)
    case choice
    when 1
      puts 'Skipped one deal'
    when 2
      @user.hand.deal!(@deck)
    else
      puts 'Wrong choice.'
      first_step
    end
  end

  def first_step
    user_hand
    puts "\n1 - Skip"
    puts '2 - Take one card'
    choice = gets.chomp.to_i
    first_step_choice(choice)
    @dealer.hand.deal!(@deck) if @dealer.hand.count_points <= 17
  end

  def last_step_choice(choice)
    case choice
    when 1
      @user.hand.deal!(@deck)
    when 2
      user_hand
    else
      puts 'Wrong choice.'
    end
    @dealer.hand.deal!(@deck) if @dealer.hand.count_points <= 17 &&
                                 @dealer.hand.cards_number < 3
  end

  # rubocop:disable all
  def play_game
    first_step
    loop do
      user_hand
      if @user.hand.cards_number.eql?(3)
        break
      end

      puts '1 - Take one card'
      puts '2 - Show cards'
      choice = gets.chomp.to_i
      last_step_choice(choice)
      break if choice.eql?(2)
    end
  end
  # rubocop:enable all
end
