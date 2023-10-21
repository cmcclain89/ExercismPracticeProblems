defmodule BoutiqueInventory do

  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price)
  end
  def with_missing_price(inventory) do
    Enum.filter(inventory, &(!&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn x -> %{x | name: String.replace(x.name, old_word, new_word)} end)
  end

  def increase_quantity(item, count) do
    %{item | quantity_by_size: Map.new(Enum.map(item.quantity_by_size, fn {k, v} -> {k, v + count} end))}
  end

  def total_quantity(%{quantity_by_size: quantities}) do
    quantities
    |> Enum.reduce(0, fn {_k, v}, acc -> v + acc end)
  end
end
