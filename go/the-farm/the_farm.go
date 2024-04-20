package thefarm

import (
	"errors"
	"fmt"
)

// TODO: define the 'DivideFood' function
func DivideFood(calc FodderCalculator, numOfCows int) (float64, error) {
	amount, fodErr := calc.FodderAmount(numOfCows)

	if fodErr != nil {
		return 0, fodErr
	} else {
		factor, fatErr := calc.FatteningFactor()
		if fatErr != nil {
			return 0, fatErr
		} else {
			return amount * factor / float64(numOfCows), nil
		}
	}
}

// TODO: define the 'ValidateInputAndDivideFood' function
func ValidateInputAndDivideFood(calc FodderCalculator, numOfCows int) (float64, error) {
	if numOfCows > 0 {
		return DivideFood(calc, numOfCows)
	} else {
		return 0, errors.New("invalid number of cows")
	}
}

type InvalidCowsError struct {
	numOfCows int
	message   string
}

func (e *InvalidCowsError) Error() string {
	return fmt.Sprintf("%d cows are invalid: %s", e.numOfCows, e.message)
}

// TODO: define the 'ValidateNumberOfCows' function
func ValidateNumberOfCows(numOfCows int) error {
	if numOfCows < 0 {
		return &InvalidCowsError{
			numOfCows: numOfCows,
			message:   "there are no negative cows",
		}
	} else if numOfCows == 0 {
		return &InvalidCowsError{
			numOfCows: numOfCows,
			message:   "no cows don't need food",
		}
	} else {
		return nil
	}
}

// Your first steps could be to read through the tasks, and create
// these functions with their correct parameter lists and return types.
// The function body only needs to contain `panic("")`.
//
// This will make the tests compile, but they will fail.
// You can then implement the function logic one by one and see
// an increasing number of tests passing as you implement more
// functionality.
