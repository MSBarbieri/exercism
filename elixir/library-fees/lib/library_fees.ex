defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    before_noon = before_noon?(checkout_datetime)

    if before_noon do
      dt = NaiveDateTime.add(checkout_datetime, 28, :day)
      NaiveDateTime.to_date(dt)
    else
      dt = NaiveDateTime.add(checkout_datetime, 29, :day)
      NaiveDateTime.to_date(dt)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(actual_return_datetime, planned_return_date) |> max(0)
  end

  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_dt = datetime_from_string(checkout)
    return_dt = datetime_from_string(return)

    days_late = days_late(return_date(checkout_dt), return_dt)

    fee = days_late * rate

    cond do
      monday?(return_dt) ->
        (fee / 2) |> trunc()

      true ->
        fee
    end
  end
end
