import gleam/int
import gleam/list

pub fn square_of_sum(n: Int) -> Int {
  let result: Int =
    list.range(1, n)
    |> int.sum()

  result * result
}

pub fn sum_of_squares(n: Int) -> Int {
  list.range(1, n)
  |> list.map(fn(x) { x * x })
  |> int.sum()
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
