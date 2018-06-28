module CardDeck
  CARD_DECK = ['T^', 'T<>', 'T+', 'T<3', 'K^', 'K<>', 'K+', 'K<3', 'Д^', 'Д<>', 'Д+', 'Д<3', \
               'В^', 'В<>', 'В+', 'В<3', '10^', '10<>', '10+', '10<3', '9^', '9<>', '9+', '9<3',\
               '8^', '8<>', '8+', '8<3', '7^', '7<>', '7+', '7<3', '6^', '6<>', '6+', '6<3', \
               '5^', '5<>', '5+', '5<3', '4^', '4<>', '4+', '4<3', '3^', '3<>', '3+', '3<3', \
               '2^', '2<>', '2+', '2<3']

  protected

  def start_cards
    [CARD_DECK.sample, CARD_DECK.sample]
  end

end