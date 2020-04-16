# frozen_string_literal: true

class Dealer < Player
  def initialize(name = 'Dealer')
    @name = name
    super()
  end
end
