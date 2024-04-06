defmodule RemoteControlCar do
  # Please implement the struct with the specified fields
  @enforce_keys :nickname
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    remote_car = new()
    %{remote_car | nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery}) do
    if battery > 0 do
      "Battery at #{battery}%"
    else
      "Battery empty"
    end
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car

  def drive(%RemoteControlCar{} = car) do
    new_battery = car.battery_percentage - 1
    new_distance = car.distance_driven_in_meters + 20
    %{car | battery_percentage: new_battery, distance_driven_in_meters: new_distance}
  end
end
