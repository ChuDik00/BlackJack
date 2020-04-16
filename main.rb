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

def create_dealer
  Dealer.new
rescue RuntimeError => e
  puts e.message
  retry
end

user = create_user
dealer = create_dealer
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
  puts "Balance of Dealer = #{dealer.balance}\n"
  print 'Play again? (y/n) '
  play = gets.chomp
  case play
  when 'y'
    puts 'Shuffle cards and start new game!'
  when 'n'
    puts 'Game over!'
    break
  else
    puts 'Wrong input. Press y or n'
  end
end
