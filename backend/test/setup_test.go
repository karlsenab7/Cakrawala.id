package test

import (
	"bytes"
	"cakrawala.id/m/controllers"
	"cakrawala.id/m/middleware"
	"cakrawala.id/m/models"
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"github.com/stretchr/testify/suite"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"net/http"
	"net/http/httptest"
	"os"
	"testing"
	"time"
)

type TestSuiteEnv struct {
	suite.Suite
	db *gorm.DB
}

// Tests are run before they start
func (suite *TestSuiteEnv) SetupSuite() {
	if lf := os.Getenv("LF"); lf != "Y" {
		godotenv.Load("../.env.test")
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
	database, err := gorm.Open(postgres.Open(dbUrl), &gorm.Config{})

	if err != nil {
		fmt.Println(err)
		panic("Failed to connect to database!")
	}

	err = database.AutoMigrate(&models.User{}, &models.Auth{}, &models.Merchant{}, &models.Reward{}, &models.Transaksi{}, &models.HistoryReward{})
	if err != nil {
		return
	}

	models.DB = database
	suite.db = models.DB
}

// Running after each test
func (suite *TestSuiteEnv) TearDownTest() {
	models.ClearTable()
}

// Running after all tests are completed
func (suite *TestSuiteEnv) TearDownSuite() {
	//suite.db.Close()
}

// This gets run automatically by `go test` so we call `suite.Run` inside it
func TestSuite(t *testing.T) {
	// This is what actually runs our suite
	suite.Run(t, new(TestSuiteEnv))
}

func (suite *TestSuiteEnv) TestRegister() {
	r := gin.New()
	r.POST("/register", controllers.Register)
	var jstr = []byte(`{
    "email" : "13519002@std.stei.itb.ac.id",
    "name" : "robert alfonsius",
    "phone" : "085257560828",
    "password" : "asdf12345"
	}`)
	a := suite.Assert()
	req, err := http.NewRequest(http.MethodPost, "/register", bytes.NewBuffer(jstr))
	req.Header.Set("Content-Type", "application/json")

	if err != nil {
		a.Error(err)
	}

	w := httptest.NewRecorder()
	r.ServeHTTP(w, req)

	a.Equal(w.Code, 200)

	w = httptest.NewRecorder()
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 400)

}

func (suite *TestSuiteEnv) TestLogin() {
	r := gin.New()
	r.POST("/register", controllers.Register)
	r.POST("/login", controllers.Login)
	var jstr = []byte(`{
    "email" : "13519002@std.stei.itb.ac.id",
    "name" : "robert alfonsius",
    "phone" : "085257560828",
    "password" : "asdf12345"
	}`)

	var lstr = []byte(`{
		"email" : "13519002@std.stei.itb.ac.id",
		"password" : "asdf12345"
	}`)

	var lErrPassstr = []byte(`{
		"email" : "13519002@std.stei.itb.ac.id",
		"password" : "asdf12f34"
	}`)

	var lErrEmailstr = []byte(`{
		"email" : "13519002w@std.stei.itb.ac.id",
		"password" : "asdf12345"
	}`)
	a := suite.Assert()
	req, err := http.NewRequest(http.MethodPost, "/register", bytes.NewBuffer(jstr))
	req.Header.Set("Content-Type", "application/json")
	if err != nil {
		a.Error(err)
	}

	w := httptest.NewRecorder()
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 200)

	w = httptest.NewRecorder()
	req, err = http.NewRequest(http.MethodPost, "/login", bytes.NewBuffer(lstr))
	req.Header.Set("Content-Type", "application/json")
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 200)

	w = httptest.NewRecorder()
	req, err = http.NewRequest(http.MethodPost, "/login", bytes.NewBuffer(lErrPassstr))
	req.Header.Set("Content-Type", "application/json")
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 403)

	w = httptest.NewRecorder()
	req, err = http.NewRequest(http.MethodPost, "/login", bytes.NewBuffer(lErrEmailstr))
	req.Header.Set("Content-Type", "application/json")
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 404)
}

type LoginResp struct {
	User   models.User `json:"user"`
	Token  string      `json:"token"`
	Expire time.Time   `json:"expire"`
}

func (suite *TestSuiteEnv) TestMiddleware() {
	r := gin.New()
	r.POST("/register", controllers.Register)
	r.POST("/login", controllers.Login)
	r.GET("/self", middleware.IsAuthrorized(), controllers.UserInfo)
	var jstr = []byte(`{
    "email" : "13519002@std.stei.itb.ac.id",
    "name" : "robert alfonsius",
    "phone" : "085257560828",
    "password" : "asdf12345"
	}`)

	var lstr = []byte(`{
		"email" : "13519002@std.stei.itb.ac.id",
		"password" : "asdf12345"
	}`)

	a := suite.Assert()
	req, err := http.NewRequest(http.MethodPost, "/register", bytes.NewBuffer(jstr))
	req.Header.Set("Content-Type", "application/json")
	if err != nil {
		a.Error(err)
	}

	w := httptest.NewRecorder()
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 200)

	w = httptest.NewRecorder()
	req, err = http.NewRequest(http.MethodPost, "/login", bytes.NewBuffer(lstr))
	req.Header.Set("Content-Type", "application/json")
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 200)

	var userdata LoginResp
	if e := json.Unmarshal(w.Body.Bytes(), &userdata); e != nil {
		a.Error(e)
	}

	w = httptest.NewRecorder()
	req, err = http.NewRequest(http.MethodGet, "/self", nil)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", userdata.Token)
	r.ServeHTTP(w, req)
	a.Equal(w.Code, 200)
	var selfdata models.User
	if e := json.Unmarshal(w.Body.Bytes(), &selfdata); e != nil {
		a.Error(e)
	}
	a.Equal(selfdata.Email, "13519002@std.stei.itb.ac.id")
	a.Equal(selfdata.Name, "robert alfonsius")
	a.Equal(selfdata.Phone, "085257560828")
}
