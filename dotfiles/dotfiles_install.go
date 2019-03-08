package main

import (
	"bytes"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"strings"

	"gopkg.in/yaml.v2"
)

type actionItem struct {
	Name      string
	Action    string
	ConfigLoc string `yaml:"config_loc"`
	RefLoc    string `yaml:"ref_loc"`
}

func check(e error, reason string) {
	if e != nil {
		infoStr := ""
		if reason != "" {
			infoStr += "[INFO]  " + reason
		}
		log.Println(infoStr)
		log.Fatal("[ERROR] " + e.Error())
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Missing yaml file for tasks!")
		printUsage()
		return
	}
	b, err := ioutil.ReadFile(os.Args[1])
	check(err, "Cannot read yaml config")

	pwd, _ := os.Getwd()

	var actionItems []actionItem
	err = yaml.Unmarshal(b, &actionItems)
	check(err, "Cannot unmarshall yaml config")

	for _, item := range actionItems {
		fileLoc := pwd + "/files/" + item.RefLoc
		switch action := item.Action; action {
		case "append":
			appendToFile(fileLoc, item.ConfigLoc)
		case "replace":
			replaceFile(fileLoc, item.ConfigLoc)
		case "insert_json":
			insertContentToJSON(fileLoc, item.ConfigLoc)
		}
	}
}

func appendToFile(fileLoc, configLoc string) {
	runBash("cat", fileLoc, ">>", configLoc)
}

func replaceFile(fileLoc, configLoc string) {
	runBash("cp", "-r", fileLoc, configLoc)
}

func insertContentToJSON(fileLoc, configLoc string) {
	fmt.Println(fileLoc, configLoc)
}

func runBash(cmdStr string, params ...string) (string, string) {
	var cmd *exec.Cmd
	cmd = exec.Command(cmdStr, params...)
	stdout, _ := cmd.StdoutPipe()
	stderr, _ := cmd.StderrPipe()
	var stdoutBuffer bytes.Buffer
	var stderrBuffer bytes.Buffer
	stdoutWriter := io.MultiWriter(os.Stdout, &stdoutBuffer)
	stderrWriter := io.MultiWriter(os.Stderr, &stderrBuffer)

	err := cmd.Start()
	check(err, "In "+cmdStr)

	go io.Copy(stdoutWriter, stdout)
	go io.Copy(stderrWriter, stderr)

	err = cmd.Wait() // by the time cmd finished, stdoutBuffer/stderrBuffer is filled
	check(err, "In "+cmdStr)

	return strings.TrimSuffix(stdoutBuffer.String(), "\n"), strings.TrimSuffix(stderrBuffer.String(), "\n")
}

func printUsage() {
	fmt.Printf("Usage: go run dotfiles_install.go config.yaml\n")
}
