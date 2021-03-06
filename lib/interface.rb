# frozen_string_literal: true

class Interface
  attr_reader :dealer, :user, :deck

  def initialize
    @deck = Deck.new
    @user = create_user
    @user.hand = Hand.new
    @dealer = Dealer.new
    @dealer.hand = Hand.new
    2.times { @user.hand.deal!(@deck) }
    2.times { @dealer.hand.deal!(@deck) }
  end

  def create_user
    print 'Insert your name: '
    name = gets.chomp
    User.new(name)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def hello
    puts "Hello, #{@user.name}!"
    puts 'Lets begin BlackJack!'
  end

  def game_over
    game_over = nil
    until game_over.eql?('y') || game_over.eql?('n')
      print "\nPlay again? (y/n) "
      game_over = gets.chomp.downcase
    end
    game_over
  end

  def dead_heat
    puts 'Dead heat!'
  end

  def your_victory
    puts 'Your victory!'
  end

  def dealer_victory
    puts 'Dealer victory!'
  end

  def user_hand
    puts "\nYour cards: "
    @user.hand.show_cards
    print 'Your scores: '
    puts @user.hand.count_points
  end

  def user_balance
    puts "Balance of #{@user.name} = #{@user.balance}"
  end

  def dealer_balance
    puts "Balance of Dealer = #{@dealer.balance}"
  end

  def draw_stars
    puts '*' * 20
  end

  def dealer_hand
    puts 'Dealer cards: '
    @dealer.hand.show_cards
    print 'Dealer scores: '
    puts @dealer.hand.count_points
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

  # rubocop:disable all
  def last_step_choice
    puts '1 - Take one card'
    puts '2 - Show cards'
    choice = gets.chomp.to_i
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
    choice
  end
  # rubocop:enable all
end
