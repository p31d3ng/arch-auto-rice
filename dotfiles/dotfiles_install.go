package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"os/exec"

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
			runBash("ls", "-l", fileLoc)
		}
	}
}

func runBash(cmdStr string, params ...string) {
	var cmd *exec.Cmd
	cmd = exec.Command(cmdStr, params...)
	stdout, _ := cmd.StdoutPipe()
	stderr, _ := cmd.StderrPipe()
	err := cmd.Start()
	check(err, "In "+cmdStr)

	go io.Copy(os.Stdout, stdout)
	go io.Copy(os.Stderr, stderr)
	err = cmd.Wait()
	check(err, "In "+cmdStr)
}

func printUsage() {
	fmt.Printf("Usage: go run dotfiles_install.go config.yaml\n")
}
