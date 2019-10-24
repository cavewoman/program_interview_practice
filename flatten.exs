defmodule Flatten do
  def smash(structure) do
    smash(structure, [], [])
  end

  def smash([], acc, []) do
    acc
  end

  def smash([], acc, left) do
    smash(left, acc, [])
  end

  def smash([nil | t], acc, left) do
    smash(t, acc, left)
  end

  def smash([h|t], acc, []) when Kernel.is_list(h) == true do
    smash(h, acc, t)
  end

  def smash([h|t], acc, left) when Kernel.is_list(h) == true do
    smash(h, acc, [t|left])
  end

  def smash([h|t], acc, left) do
    smash(t, acc ++ [h], left)
  end


  def test(case) do
		{input, expected} = case
		# IO.inspect(input)
		# IO.inspect(Flatten.smash(input))
		case Flatten.smash(input) == expected do
			true ->
				IO.puts("PASSED!")
			_ ->
				IO.puts("FAILED!")
		end
	end
end


cases = [	{[[]], []},
				 	{[1, 2, nil], [1,2]},
					{[1, [2,3,4], 5], [1,2,3,4,5]},
					{[1, [2,3,4],5,[6,[7,8]]], [1,2,3,4,5,6,7,8]},
			    {[0,2,[[2,3],8,100,4,[[[50]]]],-2], [0,2,2,3,8,100,4,50,-2]},
					{[1,[2,[[3]],[4,[[5]]],6,7],8], [1,2,3,4,5,6,7,8]},
					{[0,2,[[2,3],8,[[100]],nil,[[nil]]],-2], [0,2,2,3,8,100,-2]},
					{[nil,[[[nil]]],nil,nil,[[nil,nil],nil],nil], []},
				]

Enum.map(cases, &Flatten.test/1)
