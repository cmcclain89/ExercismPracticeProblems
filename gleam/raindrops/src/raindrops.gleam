import gleam/int

pub fn convert(number: Int) -> String {
  let result =
    pling(number)
    |> plang(number)
    |> plong(number)

  case result {
    "" -> int.to_string(number)
    _ -> result
  }
}

fn pling(number: Int) -> String {
  case number % 3 {
    0 -> "Pling"
    _ -> ""
  }
}

fn plang(current: String, number: Int) -> String {
  case number % 5 {
    0 -> current <> "Plang"
    _ -> current <> ""
  }
}

fn plong(current: String, number: Int) -> String {
  case number % 7 {
    0 -> current <> "Plong"
    _ -> current <> ""
  }
}
