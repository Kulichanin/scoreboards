package dbexporter

import (
	"context"
	"database/sql"
	"time"

	_ "github.com/jackc/pgx/v5/stdlib"
)

// Завернуть все в интерфейс для передачи состояния БД в отдельном и работы с ней через интерфейс.
func Pingdb(urlBd string) error {
	db, err := sql.Open("pgx", urlBd)
	if err != nil {
		return err
	}
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	err = db.PingContext(ctx)
	if err != nil {
		return err
	}
	return nil
}
