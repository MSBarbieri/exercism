defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a, b}, {c, d}) do
    {a * d + b * c, b * d} |> reduce
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a, b}, {c, d}) do
    {a * d - b * c, b * d} |> reduce
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a, b}, {c, d}) do
    {a * c, b * d} |> reduce
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a, b}, {c, d}) do
    {a * d, b * c} |> reduce
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) do
    one =
      cond do
        a < 0 -> -a
        true -> a
      end

    two =
      cond do
        b < 0 -> -b
        true -> b
      end

    {one, two} |> reduce
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0 do
    {b ** -n, a ** -n} |> reduce
  end

  def pow_rational({a, b}, n) do
    {a ** n, b ** n} |> reduce
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    x ** (a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) when b < 0 do
    gcd = gcd(a, b)
    {-a / gcd, -b / gcd}
  end

  def reduce({num, den}) do
    gcd = gcd(num, den)
    {num / gcd, den / gcd}
  end

  defp gcd(a, 0), do: Kernel.abs(a)
  defp gcd(a, b), do: gcd(b, rem(a, b))
end
