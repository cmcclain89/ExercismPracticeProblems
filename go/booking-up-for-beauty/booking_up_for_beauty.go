package booking

import (
	"fmt"
	"time"
)

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	layout := "1/2/2006 15:04:05"
	t, _ := time.Parse(layout, date)
	return t
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	layout := "January 2, 2006 15:04:05"
	t, _ := time.Parse(layout, date)

	return time.Now().After(t)
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	layout := "Monday, January 2, 2006 15:04:05"
	t, _ := time.Parse(layout, date)

	h, _, _ := t.Clock()
	return h >= 12 && h < 16
}

// Description returns a formatted string of the appointment time.
func Description(date string) string {
	schedule_date := Schedule(date)
	return fmt.Sprintf("You have an appointment on %s, %s %d, %d, at %d:%d.", schedule_date.Weekday(), schedule_date.Month(), schedule_date.Day(), schedule_date.Year(), schedule_date.Hour(), schedule_date.Minute())
}

// AnniversaryDate returns a Time with this year's anniversary.
func AnniversaryDate() time.Time {
	t := time.Date(time.Now().Year(), time.September, 15, 0, 0, 0, 0, time.UTC)
	return t
}
