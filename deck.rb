# frozen_string_literal: true

require_relative './card'

class Deck
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    @cards = []
    %w[♠ ♥ ♦ ♣].each do |suit|
      (2..10).each do |face|
        @cards << Card.new(suit, face)
      end
      %w[J Q K A].each do |face|
        @cards << Card.new(suit, face)
      end
    end
    @cards.shuffle.reverse.shuffle
  end
end
