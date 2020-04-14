class Hand
  def initialize
    @cards = []
  end

  def deal!(deck)
    @cards << deck.cards.shift
  end

  def show_cards
    @cards.each_with_index do |card, count|
      puts "#{count+1}: #{card.face}#{card.suit}"
    end
  end

  def count_points
    points = 0
    @cards.each do |card|
      points += card.rank
    end
  end


end
