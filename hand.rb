class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def deal!(deck)
    @cards << deck.cards.shift
  end

  def cards_number
    @cards.size
  end

  def show_cards
    @cards.each_with_index do |card, count|
      puts "#{count + 1}: #{card.face}#{card.suit}"
    end
  end

  def count_points
    points = 0
    @cards.each do |card|
      points += if card.face.eql?('A')
                  ace_count_points(points, card.rank)
                else
                  card.rank
                end
    end
    points
  end

  def ace_count_points(points, card_rank)
    ace_rank = if points + card_rank <= 21
                 card_rank
               else
                 1
               end
    ace_rank
  end
end
