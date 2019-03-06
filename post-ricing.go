package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"strings"

	"gopkg.in/yaml.v2"
)

type tasks []taskStruct

type taskStruct struct {
	Name        string
	Description string
	Enable      bool
	Depends     []string
	Scripts     []struct {
		Loc    string
		Type   string
		Params []string
	}
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

	var ts tasks
	err = yaml.Unmarshal(b, &ts)
	check(err, "Cannot unmarshall yaml config")
	runMap := make(map[string]int)
	// get enable status of all tasks
	for i, t := range ts {
		run := -1
		if t.Enable {
			for _, s := range t.Scripts {
				if len(s.Type) == 0 {
					log.Printf("[INFO] %v | %v - Missing runtime type! skipping \"%v\"\n", t.Name, s.Loc, t.Name)
					run = -1
					break
				}
				if _, err := os.Stat(pwd + "/" + s.Loc); err == nil {
					run = i
				} else if os.IsNotExist(err) {
					run = -1
					break
				}
			}
		}
		runMap[t.Name] = run
	}

	// determine dependencies
	fmt.Printf("\n-----------------")
	fmt.Printf("The following tasks will run:")
	fmt.Println("-----------------")
	exitFlag := false
	for _, t := range ts {
		for _, dName := range t.Depends {
			if v, ok := runMap[dName]; !ok || v < 0 {
				runMap[t.Name] = -1
				break
			} else if v > -1 && runMap[t.Name] > -1 && v > runMap[t.Name] {
				fmt.Printf("[ERROR] Please define \"%v\" before \"%v\", I don't want to deal with topological sort at the moment :(\n", dName, t.Name)
				exitFlag = true
			}
		}
		if runMap[t.Name] > -1 && !exitFlag {
			fmt.Println("*", t.Name)
		}
	}

	if exitFlag {
		os.Exit(1)
	}

	for _, t := range ts {
		if runMap[t.Name] > -1 {
			fmt.Printf("\n-----------------")
			fmt.Printf("Running " + t.Name)
			fmt.Println("-----------------")
			for _, s := range t.Scripts {
				var cmd *exec.Cmd
				scriptLoc := pwd + "/" + s.Loc
				paramStr := strings.Join(s.Params, " ")
				if s.Type == "bash" || s.Type == "fish" {
					cmd = exec.Command(scriptLoc, paramStr)
				} else if s.Type == "go" {
					cmd = exec.Command("go run "+scriptLoc, paramStr)
				} else if s.Type == "python3" {
					cmd = exec.Command("python3 "+scriptLoc, paramStr)
				} else {
					log.Printf("[INFO] Runtime \"%v\" not supported yet!\n", s.Type)
					continue
				}
				stdout, _ := cmd.StdoutPipe()
				stderr, _ := cmd.StderrPipe()
				err := cmd.Start()
				check(err, "In "+t.Name+" - "+s.Loc)

				go io.Copy(os.Stdout, stdout)
				go io.Copy(os.Stderr, stderr)
				cmd.Wait()
			}
			fmt.Printf("-----------------")
			fmt.Printf("Finished " + t.Name)
			fmt.Println("-----------------")
		}
	}

	fmt.Printf("\n-----------------")
	fmt.Printf("Post Ricing Finshed!")
	fmt.Println("-----------------")

}

func printUsage() {
	fmt.Printf("Usage: go run post-ricing.go post-ricing-tasks.yaml\n")
}
