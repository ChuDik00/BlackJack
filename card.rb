class Card
  attr_reader :suit, :face, :rank

  def initialize(suit, face)
    @suit = suit
    @face = face
    @rank = rank
  end

  def rank
    return 10 if ['J', 'Q', 'K'].include?(@face)
    @rank
  end
end
