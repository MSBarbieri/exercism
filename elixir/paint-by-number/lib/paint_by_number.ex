defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    check_max(color_count, 1)
  end

  defp check_max(color_count, bit_size) do
    size = Integer.pow(2, bit_size)

    cond do
      color_count < size ->
        bit_size

      color_count > size ->
        check_max(color_count, bit_size + 1)

      true ->
        bit_size
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    # <<0b0::2, 0b1::2, 0b10::2, 0b11::2>>
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    s = palette_bit_size(color_count)
    <<pixel_color_index::size(s), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    s = palette_bit_size(color_count)
    <<pixel_color_index::size(s), _::bitstring>> = picture
    pixel_color_index
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    s = palette_bit_size(color_count)
    <<_::size(s), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
