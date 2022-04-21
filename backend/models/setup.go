package models

import (
	"fmt"
	"os"

	"github.com/joho/godotenv"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
	err := godotenv.Load(".env")

	if err != nil {
		panic("gawatt, env tidak terdeteksii")
	}

	dbUsn := os.Getenv("DBUSN")
	dbPass := os.Getenv("DBPASS")
	dbHost := os.Getenv("DBHOST")
	dbPort := os.Getenv("DBPORT")
	dbName := os.Getenv("DBNAME")

	dbUrl := fmt.Sprintf("postgres://%s:%s@%s:%s/%s",
		dbUsn,
		dbPass,
		dbHost,
		dbPort,
		dbName)
	fmt.Println("try to call env from models: ", dbPass)
	database, err := gorm.Open(postgres.Open(dbUrl), &gorm.Config{})

	if err != nil {
		fmt.Println(err)
		panic("Failed to connect to database!")
	}

	database.AutoMigrate(&User{}, &Auth{}, &Merchant{}, &Reward{}, &Transaksi{}, &HistoryReward{})

	DB = database
}

func ClearTable() {
	DB.Exec("DELETE FROM auths")
	DB.Exec("DELETE FROM history_rewards")
	DB.Exec("DELETE FROM merchants")
	DB.Exec("DELETE FROM rewards")
	DB.Exec("DELETE FROM transaksis")
	DB.Exec("DELETE FROM users")
}
