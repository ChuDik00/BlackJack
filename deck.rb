require_relative './card'

class Deck
  attr_reader :cards


  def initialize
    @cards = create_deck
  end

  def create_deck
    @cards = []
    ['+', '^', '<', '<>'].each do |suit|
      (2..10).each do |face|
        @cards << Card.new(suit, face)
      end
      ['J', 'Q', 'K', 'A'].each do |face|
        @cards << Card.new(suit, face)
      end
    end
    @cards.shuffle.reverse.shuffle
  end
end

deck = Deck.new
deck.cards.each do |card|
  puts card.show_card
end