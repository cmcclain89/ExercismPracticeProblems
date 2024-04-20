package parsinglogfiles

import (
	"fmt"
	"regexp"
	"strings"
)

func IsValidLine(text string) bool {
	matched, _ := regexp.MatchString(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`, text)
	return matched
}

func SplitLogLine(text string) []string {
	return regexp.MustCompile(`<([~*=-]*)>`).Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	expression := regexp.MustCompile(`"([\w\s]*)password([\w\s]*)"`)
	count := 0
	for _, s := range lines {
		if expression.MatchString(strings.ToLower(s)) {
			count++
		}
	}
	return count
}

func RemoveEndOfLineText(text string) string {
	expression := regexp.MustCompile(`end-of-line([\d]{1,})`)
	return expression.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	expression := regexp.MustCompile(`User([\s]{1,})([\w]{1,})`)
	for i := 0; i < len(lines); i++ {
		if expression.MatchString(lines[i]) {
			user_sub := expression.FindStringSubmatch(lines[i])
			user := regexp.MustCompile(`User([\s]*)`).ReplaceAllString(user_sub[0], "")
			lines[i] = fmt.Sprintf("[USR] %s %s", user, lines[i])
		}
	}
	return lines
}
