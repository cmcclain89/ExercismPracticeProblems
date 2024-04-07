defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(term, character)
  end

  defimpl Edible, for: RPG.LoafOfBread do
    def eat(_term, character) do
      {nil, %RPG.Character{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: RPG.ManaPotion do
    def eat(term, character) do
      {%RPG.EmptyBottle{}, %RPG.Character{character | mana: character.mana + term.strength}}
    end
  end

  defimpl Edible, for: RPG.Poison do
    def eat(_term, character) do
      {%RPG.EmptyBottle{}, %RPG.Character{character | health: 0}}
    end
  end
end
