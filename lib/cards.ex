defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  def hello do
    :world
  end

  @type card :: charlist()
  @type deck :: [card, ...]
  @type hand :: deck

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

  @spec shuffle(deck) :: deck
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @spec contains?(deck, card) :: boolean
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @spec deal(deck, number) :: {hand, deck}
  def deal(deck, hand_size) do
    if hand_size <= 0 do
      raise "Hand size should be greater then 0"
    end

    Enum.split(deck, hand_size)
  end

  @spec save(deck, charlist) :: :ok
  def save(deck, filename) do
    content = :erlang.term_to_binary(deck)
    File.write(filename, content)
  end

  @spec load(charlist) :: deck
  def load(filename) do
    case File.read(filename) do
      {:ok, content} -> :erlang.binary_to_term(content)
      {:error, _reason} -> raise "File.read failed"
    end
  end

  @spec create_hand(number) :: hand
  def create_hand(hand_size) do
    Cards.create_deck() |> Cards.shuffle() |> Cards.deal(hand_size)
  end
end
