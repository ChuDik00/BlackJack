require_relative 'card'

class Deck
  include Validation
  attr_reader :cards

  validate :cards, :dulicate
  def initialize
    @cards = create_deck
  end

  def create_deck
    @cards = []
    suits = ["+", "^", "<", "<>"]
    digital_faces = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    higher_faces = ['J', 'Q', 'K', 'A']
    suits.each do |suit|
      digital_faces.each do |face|
        @cards << Card.new(suit, face)
      end
      higher_faces.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    @cards.shuffle.reverse.shuffle
  end
end

deck = Deck.new
p deck.cards
p deck.cards.size