class Player
  attr_accessor :hand
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def increase_balance
    @balance += 10
  end

  def decrease_balance
    @balance -= 10
  end
end
