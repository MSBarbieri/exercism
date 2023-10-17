defmodule HighSchoolSweetheart do
  def first_letter(name) do
    # Please implement the first_letter/1 function
    name |> String.trim() |> String.first()
  end

  def initial(name) do
    # Please implement the initial/1 function
    name |> first_letter |> String.upcase() |> Kernel.<>(".")
  end

  def initials(full_name) do
    # Please implement the initials/1 function
    full_name |> String.upcase() |> String.split() |> Enum.map(fn x -> initial(x) end) |> concat
  end

  def concat([first, last]) do
    first <> " " <> last
  end

  def pair(full_name1, full_name2) do
    f_name = initials(full_name1)
    s_name = initials(full_name2)

    result = """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{f_name}  +  #{s_name}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """

    # Please implement the pair/2 function
  end
end
