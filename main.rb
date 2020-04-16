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
#Выводится новый запрос на игру типа играем ещё да/нет?

#здесь вся игра лупе получается
