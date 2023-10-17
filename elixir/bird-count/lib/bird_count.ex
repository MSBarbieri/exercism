defmodule BirdCount do
  def today([head | _]) do
    head
  end

  def today([]) do
    nil
  end

  def increment_day_count([head | tail]) do
    # Please implement the increment_day_count/1 function
    [head + 1 | tail]
  end

  def increment_day_count([]) do
    # Please implement the increment_day_count/1 function
    [1]
  end

  def has_day_without_birds?(list) do
    # Please implement the has_day_without_birds?/1 function
    case list do
      [0 | tail] -> true
      [_ | tail] -> has_day_without_birds?(tail)
      _ -> false
    end
  end

  def total(list) do
    # Please implement the total/1 function
    case list do
      [head | tail] -> head + total(tail)
      _ -> 0
    end
  end

  def busy_days([head | tail]) do
    cond do
      head >= 5 ->
        1 + busy_days(tail)

      true ->
        busy_days(tail)
    end
  end

  def busy_days([]) do
    0
  end
end
