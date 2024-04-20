package logs

import (
	"fmt"
	"unicode/utf8"
)

// Application identifies the application emitting the given log.
func Application(log string) string {
	for _, c := range log {
		switch fmt.Sprintf("%U", c) {
		case "U+2757":
			return "recommendation"
		case "U+1F50D":
			return "search"
		case "U+2600":
			return "weather"
		}
	}

	return "default"
}

// Replace replaces all occurrences of old with new, returning the modified log
// to the caller.
func Replace(log string, oldRune, newRune rune) string {
	new_log := ""
	for _, c := range log {
		if c == oldRune {
			new_log += string(newRune)
		} else {
			new_log += string(c)
		}
	}

	return new_log
}

// WithinLimit determines whether or not the number of characters in log is
// within the limit.
func WithinLimit(log string, limit int) bool {
	return utf8.RuneCountInString(log) <= limit
}
