require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    @cards = []
    suits = ["+", "^", "<", "<>"]
    ranks_digital = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    ranks_high = ['J', 'Q', 'K', 'A']
    suits.each do |suit|
      ranks_digital.each do |rank_digital|
        @cards << Card.new(suit, rank_digital)
      end
      ranks_high.each do |rank_high|
        @cards << Card.new(suit, rank_high)
      end
    end
    @cards.shuffle.reverse.shuffle
  end
end

deck = Deck.new
p deck.cards
p deck.cards.size