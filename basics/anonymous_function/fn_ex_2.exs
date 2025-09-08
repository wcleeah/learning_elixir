ex1 = fn 
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fizz"
  (_,0,_) -> "Buzz"
  (_,_,a) -> a
end

IO.puts ex1.(0,0,1)
IO.puts ex1.(0,1,1)
IO.puts ex1.(1,0,1)
IO.puts ex1.(1,1,15)
