ex1 = fn 
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fizz"
  (_,0,_) -> "Buzz"
  (_,_,a) -> a
end

ex2 = fn (n) ->
  ex1.(rem(n,3), rem(n,5), n)
end

IO.puts ex2.(10)
IO.puts ex2.(11)
IO.puts ex2.(12)
IO.puts ex2.(13)
IO.puts ex2.(14)
IO.puts ex2.(15)
IO.puts ex2.(16)
