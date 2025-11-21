package main

import (
	"context"
	"log"

	db "github.com/Kulichanin/scoreboards/internal/db_exporter"
)

func main() {
	urlExample := "postgres://scoreboards:test123@localhost:5432/demo"
	err := db.Pingdb(urlExample)
	if err != nil {
		if err == context.DeadlineExceeded {
			log.Println("Database ping timed out!")
		} else {
			log.Fatal(err)
		}
	} else {
		log.Println("Database ping successful!")
	}
}
