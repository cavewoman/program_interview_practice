defmodule Brackets do
	def matched(string) do
    is_match?(String.graphemes(string), nil, [])
	end

  def is_match?([], nil, []) do
    true
  end

  def is_match?([], _current_open, _still_open) do
    false
  end

  def is_match?([h|t], current_open, []) do
    cond do
      is_opener?(h) ->
        is_match?(t, h, [h])
      closed_match?(current_open, h) ->
        is_match?(t, nil, [])
      true ->
        false
    end
  end


  def is_match?([h|t], current_open, [_last_open | rest] = still_open) do
    case is_opener?(h) do
      true ->
        is_match?(t, h, [h | still_open])
      _ ->
        current_open
        |> closed_match?(h)
        |> handle_closer(t, List.first(rest), rest)
    end
  end

  def handle_closer(true, list, current_open, still_open) do
    is_match?(list, current_open, still_open)
  end

  def handle_closer(false, _list, _current_open, _still_open) do
    false
  end

  def is_opener?(string) do
    Enum.member?(["[", "{", "("], string)
  end

  def closed_match?(current_opener, current_closer) do
    matches = %{"]" => "[", "}" => "{", ")" => "("}
    matches[current_closer] == current_opener
  end

	def test(case) do
		{input, expected} = case
		IO.inspect(input)
		IO.inspect(Brackets.matched(input))
		case Brackets.matched(input) == expected do
			true ->
				IO.puts("PASSED!")
			_ ->
				IO.puts("FAILED!")
		end
	end
end

cases = [	{"{}", true},
				 	{"{{", false},
					{"}{", false},
					{"{}[]", true},
					{"{[]}", true},
					{"{[}]", false},
					{"{[)][]}", false},
					{"{[]([()])}", true}
				]

Enum.map(cases, &Brackets.test/1)
