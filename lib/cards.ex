defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @type card :: charlist
  @type deck :: [card, ...]
  @type hand :: deck

  @doc """
    Return a list of strings representing a deck
  """
  @spec create_deck :: deck
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffle the deck
  """
  @spec shuffle(deck) :: deck
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains given card

  ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Diamonds")
        true

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "random_card")
        false

  """
  @spec contains?(deck, card) :: boolean
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divide a deck into a hand and the remainder of the deck.
    The `hand_size` indicates how many cards will be placed in hand

  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
  """
  @spec deal(deck, number) :: {hand, deck}
  def deal(deck, hand_size) do
    if hand_size <= 0 do
      raise "Hand size should be greater than 0"
    end

    Enum.split(deck, hand_size)
  end

  @doc """
    Save deck in fs
  """
  @spec save(deck, charlist) :: :ok
  def save(deck, filename) do
    File.write(filename, :erlang.term_to_binary(deck))
  end

  @doc """
    Load deck from fs
  """
  @spec load(charlist) :: deck
  def load(filename) do
    case File.read(filename) do
      {:ok, content} -> :erlang.binary_to_term(content)
      {:error, _reason} -> raise "File.read failed"
    end
  end

  @doc """
    Pick a hand with given `hand_size` from shuffled deck
  """
  @spec create_hand(number) :: {hand, deck}
  def create_hand(hand_size) do
    Cards.create_deck() |> Cards.shuffle() |> Cards.deal(hand_size)
  end
end
