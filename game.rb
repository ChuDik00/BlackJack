# frozen_string_literal: true

require_relative './deck'
require_relative './player'
require_relative './user'
require_relative './dealer'
require_relative './hand'
require_relative './interface'

class Game
  def initialize
    @interface = Interface.new
    @user = @interface.user
    @dealer = @interface.dealer
    @deck = @interface.deck
  end

  def start
    Interface.hello
    loop do
      abort 'Your balance is ZERO!' if @user.balance.zero?
      abort 'Dealer balance is ZERO!' if @dealer.balance.zero?
      status
      new_deal
      game_over
      abort "\nGame over!" if @game_over.eql?('n')
    end
  end

  private

  def game_over
    @game_over = nil
    until @game_over.eql?('y') || @game_over.eql?('n')
      print "\nPlay again? (y/n) "
      @game_over = gets.chomp.downcase
    end
    @game_over
  end

  def new_deal
    @deck = Deck.new
    @user.hand = Hand.new
    @dealer.hand = Hand.new
    2.times { @user.hand.deal!(@deck) }
    2.times { @dealer.hand.deal!(@deck) }
  end

  def status
    @status = game_status
    puts '*' * 20
    Interface.dead_heat if @status.zero?
    Interface.your_victory if @status.positive?
    Interface.dealer_victory if @status.negative?
    puts '*' * 20
    puts "Balance of #{@user.name} = #{@user.balance}"
    puts "Balance of Dealer = #{@dealer.balance}"
  end

  # rubocop:disable all
  def play_game
    @interface.first_step
    loop do
      @interface.user_hand
      if @user.hand.cards_number.eql?(3)
        break
      end

      puts '1 - Take one card'
      puts '2 - Show cards'
      choice = gets.chomp.to_i
      @interface.last_step_choice(choice)
      break if choice.eql?(2)
    end
  end
  # rubocop:enable all

  def game_status
    play_game
    @interface.dealer_hand
    status = calculate_status
    new_balance(status)
    status
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
end
