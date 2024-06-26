package gross

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
	units := make(map[string]int)
	units["quarter_of_a_dozen"] = 3
	units["half_of_a_dozen"] = 6
	units["dozen"] = 12
	units["small_gross"] = 120
	units["gross"] = 144
	units["great_gross"] = 1728
	return units
}

// NewBill creates a new bill.
func NewBill() map[string]int {
	bill := make(map[string]int)
	return bill
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
	_, exists := units[unit]
	if exists {
		_, exists := bill[item]
		if exists {
			bill[item] += units[unit]
		} else {
			bill[item] = units[unit]
		}

		return true
	} else {
		return false
	}
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
	switch {
	case bill[item] == 0:
		return false
	case units[unit] == 0:
		return false
	case bill[item]-units[unit] < 0:
		return false
	default:
		bill[item] -= units[unit]
		if bill[item] == 0 {
			delete(bill, item)
		}
		return true
	}
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (int, bool) {
	_, exists := bill[item]
	if !exists {
		return 0, false
	} else {
		return bill[item], true
	}
}
