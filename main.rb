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
  # Показываются результаты

  #Если есть деньги (иначе?)
  #Создаётся новая игра (с этим же игроком, значит игрок вводится здесь раньше)
  # передаётся в инициализацию в Game
  game = Game.new(user, dealer)

  game.user_hand
  game.dealer_hand

  #Выводятся результаты игры
  # (Как считать результаты? Если игры, значит в Game)
  #
  #Выводится баланс игрока и баланс дилера
  puts "Balance of #{user.name} = #{user.balance}"
  puts "Balance of Dealer = #{dealer.balance}"

  #Выводится новый запрос на игру типа играем ещё да/нет?
  print 'Play again? (y/n)'
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