defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 52 cards" do
    assert length(Cards.create_deck()) === 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck()
    refute deck === Cards.shuffle(deck)
  end

  test "create hand with given hand_size" do
    hand_size = 3
    {hand, deck} = Cards.create_hand(hand_size)
    assert length(hand) === hand_size
    assert length(deck) === 52 - hand_size
  end
end
