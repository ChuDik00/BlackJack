# frozen_string_literal: true

require_relative './card'

class Deck
  SUITS = %w[♠ ♥ ♦ ♣].freeze
  FACES = %w[J Q K A].freeze
  attr_reader :cards

  def initialize
    @cards = create_deck
  end

  def create_deck
    @cards = []

    SUITS.each do |suit|
      (2..10).each do |face|
        @cards << Card.new(suit, face)
      end

      FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    @cards.shuffle.reverse.shuffle
  end
end
