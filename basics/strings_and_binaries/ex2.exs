defmodule MyString do
  def anagram(word1, word2) do
    _anagram(Enum.sort(word1), Enum.sort(word2))
  end

  def _anagram([], []) do
    true
  end
  def _anagram([], _) do
   false 
  end
  def _anagram(_, []) do
   false 
  end

  def _anagram([head1 | tail1], [head2 | tail2]) when head1 == head2 do
    _anagram(tail1, tail2)
  end

  def _anagram([head1 | _], [head2 | _]) when head1 != head2 do
    false
  end
end
