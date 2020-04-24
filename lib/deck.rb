# frozen_string_literal: true

require_relative './card'

class Deck
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    @cards = []

    Card.suits.each do |suit|
      (2..10).each do |face|
        @cards << Card.new(suit, face)
      end

      Card.faces.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    @cards.shuffle.reverse.shuffle
  end
end
