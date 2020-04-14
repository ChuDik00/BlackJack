class Card
  attr_reader :suit, :face, :rank

  def initialize(suit, face)
    @suit = suit
    @face = face
    @rank = rank
  end

  def show_card
    puts "#{@face}#{@suit}, rank: #{@rank}"
  end

  def rank
    return face if (2..10).include?(@face)
    return 10 if ['J', 'Q', 'K'].include?(@face)
    return 11 if @face == 'A'
    @rank
  end
end
