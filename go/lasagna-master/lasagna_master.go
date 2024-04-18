package lasagna

func PreparationTime(layers []string, average_prep_time int) int {
	if average_prep_time == 0 {
		average_prep_time = 2
	}

	return len(layers) * average_prep_time
}

func Quantities(layers []string) (noodle_weight int, sauce_weight float64) {
	noodle_weight = 0
	sauce_weight = 0.0

	for i := 0; i < len(layers); i++ {
		if layers[i] == "noodles" {
			noodle_weight += 50
		} else if layers[i] == "sauce" {
			sauce_weight += 0.2
		}
	}

	return
}

func AddSecretIngredient(friendsList, myList []string) {
	myList[len(myList)-1] = friendsList[len(friendsList)-1]
}

func ScaleRecipe(amounts []float64, portions int) []float64 {
	new_recipe := make([]float64, len(amounts))

	for i := 0; i < len(amounts); i++ {
		new_recipe[i] = amounts[i] * float64(portions) * 0.5
	}

	return new_recipe
}

// Your first steps could be to read through the tasks, and create
// these functions with their correct parameter lists and return types.
// The function body only needs to contain `panic("")`.
//
// This will make the tests compile, but they will fail.
// You can then implement the function logic one by one and see
// an increasing number of tests passing as you implement more
// functionality.
