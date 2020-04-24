# frozen_string_literal: true

class Card
  SUITS = %w[♠ ♥ ♦ ♣].freeze
  FACES = %w[J Q K A].freeze
  attr_reader :suit, :face

  def self.suits
    SUITS
  end

  def self.faces
    FACES
  end

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
    return 10 if %w[J Q K].include?(@face)
    return 11 if @face == 'A'

    @rank
  end
end
