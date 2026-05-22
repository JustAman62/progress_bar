defmodule ProgressBar.Bytes do
  @mb 1_000_000
  @kb 1_000

  def format(bytes) do
    format_with_unit(bytes)
  end

  def format(current_bytes, total_bytes) do
    format_without_unit(current_bytes, total_bytes) <> "/" <> format_with_unit(total_bytes)
  end

  defp format_with_unit(bytes) do
    {_, unit} = divisor_and_unit(bytes)
    format_without_unit(bytes, bytes) <> " " <> unit
  end

  defp format_without_unit(bytes, bytes_to_determine_unit) do
    {divisor, _} = divisor_and_unit(bytes_to_determine_unit)
    to_s(bytes / divisor)
  end

  defp divisor_and_unit(bytes) when bytes < @mb, do: {@kb, "KB"}
  defp divisor_and_unit(_bytes), do: {@mb, "MB"}

  defp to_s(number) do
    truncated = trunc(number * 100) / 100
    :io_lib.format("~.2f", [truncated]) |> to_string()
  end
end
