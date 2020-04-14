require_relative 'card'

class Deck
  attr_reader :deck

  def initialize
    @deck = create_deck
  end

  def create_deck
    @deck = []
    suites = ["+", "^", "<", "<>"]
    ranks_digital = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    ranks_high = ['J', 'Q', 'K', 'A']
    suites.each do |suit|
      ranks_digital.each do |rank_digital|
        @deck << Card.new(suit, rank_digital)
      end
      ranks_high.each do |rank_high|
        @deck << Card.new(suit, rank_high)
      end
    end
    @deck.shuffle.reverse.shuffle
  end
end

deck = Deck.new
p deck.deck
p deck.deck.size