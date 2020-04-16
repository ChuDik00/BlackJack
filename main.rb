require_relative './game'


#Начинаем игру
#Создаём игрока:

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


loop do
  #Если нет денег, игра заканчивается
  abort 'Your balance is ZERO!' if user.balance.zero?
  abort 'Your balance is ZERO!' if dealer.balance.zero?

  #Если есть деньги (иначе?)
  #Создаётся новая игра (с этим же игроком, значит игрок вводится здесь раньше)
  # передаётся в инициализацию в Game
  game = Game.new(user, dealer)

  # ЗАПУСКАЕТСЯ ИГРА, возвращаются результаты игры
  # (Как считать результаты? Если игры, значит в Game)
  status = game.status
  # game.user_hand
  # game.dealer_hand

  return 'Dead heat!' if status.zero?
  return 'Your victory!' if status.positive?
  return 'Dealer victory!' if status.negative?


  #Выводится баланс игрока и баланс дилера
  puts "Balance of #{user.name} = #{user.balance}"
  puts "Balance of Dealer = #{dealer.balance}"

  #Выводится новый запрос на игру типа играем ещё да/нет?
  print 'Play again? (y/n) '
  play = gets.chomp
  case play
  when 'y'
  when 'n'
    puts 'Game over!'
    break
  else
    puts 'Wrong input'
  end

  #здесь вся игра лупе получается
end