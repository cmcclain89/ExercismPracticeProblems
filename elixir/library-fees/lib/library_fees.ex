defmodule LibraryFees do
  def datetime_from_string(string) do
    case NaiveDateTime.from_iso8601(string) do
      {:ok, datetime} -> datetime
      {:error, _} -> nil
    end
  end

  def before_noon?(datetime) do
    NaiveDateTime.to_time(datetime)
    |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    if (before_noon?(checkout_datetime)) do
      NaiveDateTime.add(checkout_datetime, 24 * 60 * 60 * 28)
      |> NaiveDateTime.to_date
    else
      NaiveDateTime.add(checkout_datetime, 24 * 60 * 60 * 29)
      |> NaiveDateTime.to_date
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    NaiveDateTime.to_date(actual_return_datetime)
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) when is_integer(datetime), do: datetime == 1

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week
    |> monday?
  end

  def calculate_late_fee(days, rate) when is_integer(days) do
    days * rate
  end

  def calculate_late_fee(checkout, return, rate) do
    naive_return = datetime_from_string(return)

    rate = return_date(datetime_from_string(checkout))
    |> days_late(naive_return)
    |> calculate_late_fee(rate)

    if monday?(naive_return), do: trunc(rate * 0.50), else: rate
  end
end
