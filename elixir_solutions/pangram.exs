defmodule Panagram do
	def isPanagram(string) do
		letters_count = string
		|> String.downcase
		|> String.replace(~r/[^a-z]/, "")
		|> String.graphemes
		|> Enum.group_by(&String.first/1)
		|> Map.keys
		|> Kernel.length

		letters_count == 26
	end

	def test(case) do
		{input, expected} = case
		IO.inspect(input)
		IO.inspect(Panagram.isPanagram(input))
		case Panagram.isPanagram(input) do
			expected ->
				IO.puts("PASSED!")
			_ ->
				IO.puts("FAILED!")
		end
	end
end

cases = [	{"", false},
				 	{"abcdefghijklmnopqrstuvwxyz", true},
					{"the quick brown fox jumps over the lazy dog", true},
					{"a quick movement of the enemy will jeopardize five gunboats", false},
					{"five boxing wizards jump quickly at it", false},
					{"the_quick_brown_fox_jumps_over_the_lazy_dog", true},
					{"the 1 quick brown fox jumps over the 2 lazy dog", true},
					{"7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog", false},
					{"Five quacking Zephyrs jolt my wax beds", true},
					{"the quick brown fox FOX jumps over with lazy dog DOG", true}
				]

Enum.map(cases, &Panagram.test/1)
