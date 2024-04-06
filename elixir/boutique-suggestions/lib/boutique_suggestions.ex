defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color,
        (options[:maximum_price] != nil and top.price + bottom.price < options[:maximum_price]) or
          top.price + bottom.price < 100 do
      {top, bottom}
    end
  end
end
