# frozen_string_literal: true

require_relative './game'

def create_user
  print 'Insert your name: '
  name = gets.chomp
  User.new(name)
rescue RuntimeError => e
  puts e.message
  retry
end

user = create_user
dealer = Dealer.new
puts "Hello, #{user.name}!"
puts 'Lets begin new game BlackJack!'
loop do
  abort 'Your balance is ZERO!' if user.balance.zero?
  abort 'Dealer balance is ZERO!' if dealer.balance.zero?
  game = Game.new(user, dealer)
  status = game.status
  puts '*' * 20
  puts 'Dead heat!' if status.zero?
  puts 'Your victory!' if status.positive?
  puts 'Dealer victory!' if status.negative?
  puts '*' * 20
  puts "Balance of #{user.name} = #{user.balance}"
  puts "Balance of Dealer = #{dealer.balance}"
  until user_out.eql?('y') || user_out.eql?('n')
    print "\nPlay again? (y/n) "
    user_out = gets.chomp.downcase
  end

  abort 'Game over!' if user_out.eql?('n')
end
