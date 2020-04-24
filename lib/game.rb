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
    @interface.hello
    loop do
      abort 'Your balance is ZERO!' if @user.balance.zero?
      abort 'Dealer balance is ZERO!' if @dealer.balance.zero?
      status
      new_deal
      game_over = @interface.game_over
      abort "\nGame over!" if game_over.eql?('n')
    end
  end

  private

  def new_deal
    @deck = Deck.new
    @user.hand = Hand.new
    @dealer.hand = Hand.new
    2.times { @user.hand.deal!(@deck) }
    2.times { @dealer.hand.deal!(@deck) }
  end

  def status
    status = game_status
    @interface.draw_stars
    @interface.dead_heat if status.zero?
    @interface.your_victory if status.positive?
    @interface.dealer_victory if status.negative?
    @interface.draw_stars
    @interface.user_balance
    @interface.dealer_balance
  end

  def play_game
    @interface.first_step
    loop do
      @interface.user_hand
      break if @user.hand.cards_number.eql?(3)

      choice = @interface.last_step_choice
      break if choice.eql?(2)
    end
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

  def game_status
    play_game
    @interface.dealer_hand
    status = calculate_status
    new_balance(status)
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
end
