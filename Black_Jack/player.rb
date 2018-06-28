class Player
  include CardDeck

  attr_reader :start_cards_deck

  def initialize(cash)
    @start_cards_deck = start_cards
  end
end