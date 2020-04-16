# frozen_string_literal: true

require_relative './validation'

class User < Player
  include Validation
  attr_accessor :name

  validate :name, :presence
  def initialize(name)
    @name = name
    validate!
    super()
  end
end
