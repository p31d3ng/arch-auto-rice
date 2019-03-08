package main

import (
	"fmt"
	"os"
	"strings"
	"testing"
	"unicode"
)

func Test_runBash(t *testing.T) {
	type args struct {
		cmdStr string
		params []string
	}
	tests := []struct {
		name     string
		args     args
		expected string
	}{
		// TODO: Add test cases.
		{"test_echo", args{"echo", []string{"abcde"}}, "abcde"},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			out, err := runBash(tt.args.cmdStr, tt.args.params...)
			if len(err) > 0 {
				t.Error(err)
				return
			}
			if out != tt.expected {
				fmt.Printf("output   (len: %v): %v\n", len(out), out)
				fmt.Printf("expected (len: %v): %v\n", len(tt.expected), tt.expected)
				t.Fail()
				return
			}
		})
	}
}

func Test_appendToFile(t *testing.T) {
	type args struct {
		fileLoc   string
		configLoc string
	}
	tests := []struct {
		name string
		args args
	}{
	// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			appendToFile(tt.args.fileLoc, tt.args.configLoc)
		})
	}
}

func Test_replaceFile(t *testing.T) {
	type args struct {
		fileLoc   string
		configLoc string
	}
	tests := []struct {
		name string
		args args
	}{
	// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			replaceFile(tt.args.fileLoc, tt.args.configLoc)
		})
	}
}

func Test_insertContentToJson(t *testing.T) {
	pwd, _ := os.Getwd()
	type args struct {
		fileLoc   string
		configLoc string
		inline    bool
	}
	tests := []struct {
		name     string
		args     args
		expected string
	}{
		// TODO: Add test cases.
		{"test1", args{pwd + "/files/tests/to_insert.json", pwd + "/files/tests/test_insert_json.json", false}, "[{\"num\":1},{\"num\":2}]"},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			res := spaceMap(insertContentToJSON(tt.args.fileLoc, tt.args.configLoc, tt.args.inline))
			if res != tt.expected {
				fmt.Println("output:  ", res)
				fmt.Println("expected:", tt.expected)
				t.Fail()
			}
		})
	}
}

func spaceMap(str string) string {
	return strings.Map(func(r rune) rune {
		if unicode.IsSpace(r) {
			return -1
		}
		return r
	}, str)
}
