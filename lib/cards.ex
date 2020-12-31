defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
      "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
      "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
      "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
      "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds",
      "Six of Spades", "Six of Clubs", "Six of Hearts", "Six of Diamonds",
      "Seven of Spades", "Seven of Clubs", "Seven of Hearts", "Seven of Diamonds",
      "Eight of Spades", "Eight of Clubs", "Eight of Hearts", "Eight of Diamonds",
      "Nine of Spades", "Nine of Clubs", "Nine of Hearts", "Nine of Diamonds",
      "Ten of Spades", "Ten of Clubs", "Ten of Hearts", "Ten of Diamonds",
      "Jack of Spades", "Jack of Clubs", "Jack of Hearts", "Jack of Diamonds",
      "Queen of Spades", "Queen of Clubs", "Queen of Hearts", "Queen of Diamonds",
      "King of Spades", "King of Clubs", "King of Hearts", "King of Diamonds"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Accepts a list of strings representing a deck of cards and returns the shuffled deck of cards'
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Accepts a list of strings representing a deck of cards and a string representing a card and
    returns true if the card is found in the deck, false if not.

    ## Examples
        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Jack of Hearts")
        true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Accepts a list of strings representing a deck of cards and a filename.
    Writes the deck of cards to the file named `filename`.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Accepts a `filename` retrieve stored list of strings representing a deck of cards.
    Returns the file contents or an error if the file does not exist.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Accepts an integer representing the requested size of the hand.
    Returns a list of strings representing a random hand of cards.
  """
  def create_hand(hand_size) do
    {hand, _rest_of_deck} = Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)

    hand
  end
end
