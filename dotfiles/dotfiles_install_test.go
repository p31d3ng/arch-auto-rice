package main

import (
	"fmt"
	"testing"
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
			insertContentToJSON(tt.args.fileLoc, tt.args.configLoc)
		})
	}
}
