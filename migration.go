package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
)

func main() {
	if len(os.Args) < 1 {
		fmt.Println("Error , add more args :'go run migration.go origin.sqlite'")
		return
	}
	var database = os.Args[1]
	dest := "dest.sqlite"

	bytesRead, err := ioutil.ReadFile(database)

	if err != nil {
		log.Fatal(err)
	}

	err = ioutil.WriteFile(dest, bytesRead, 0644)

	if err != nil {
		log.Fatal(err)
	}
	cmd := exec.Command("sqlite3", dest,".read new-db.sql")
	stderr, err := cmd.StderrPipe()
	if err != nil {
		panic(err)
	}

	if err := cmd.Start(); err != nil {
		panic(err)
	}

	errout, _ := ioutil.ReadAll(stderr)
	if err := cmd.Wait(); err != nil {
		fmt.Println(errout)
		panic(err)
	}
	fmt.Println("New Database create :",dest)

}
