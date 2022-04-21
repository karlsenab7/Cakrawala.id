package controllers

import (
	"net/http"
	"os"
	"time"

	"cakrawala.id/m/utils"
	"github.com/golang-jwt/jwt/v4"
	"github.com/joho/godotenv"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

func getenv(key string) string {
	err := godotenv.Load(".env")

	if err != nil {
		e2 := godotenv.Load("../.env.test")
		if e2 != nil {
			panic("gawatt, env tidak terdeteksii")
		}
	}

	return os.Getenv(key)
}

type RegisterReqBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
	Name     string `json:"name"`
	Phone    string `json:"phone"`
}

// Register godoc
// @Summary Register.
// @Description Add New User.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body RegisterReqBody true "Inputan yang benar"
// @Success 200 {string} Register
// @Router /register [post]
func Register(c *gin.Context) {
	data := new(RegisterReqBody)

	if err := c.ShouldBind(data); err != nil {
		c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
		return
	}

	var u models.User
	err := models.DB.Where("email = ?", data.Email).First(&u).Error
	if err == nil {
		c.JSON(400, gin.H{
			"message": "email sudah pernah dipakai",
		})
		c.Abort()
		return
	}
	password, _ := bcrypt.GenerateFromPassword([]byte(data.Password), 14)
	user := models.User{
		Email:    data.Email,
		Password: string(password),
		Name:     data.Name,
		Phone:    data.Phone,
	}

	er := models.DB.Create(&user).Error
	if er != nil {
		_ = c.AbortWithError(500, er)
		return
	}
	expiryDate := time.Now().AddDate(0, 0, 10)
	jwtToken := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"expire":    expiryDate,
		"userId":    user.ID,
		"userEmail": user.Email,
		"userPhone": user.Phone,
		"userName":  user.Name,
	})
	tokenStr, e := jwtToken.SignedString([]byte(getenv("JWTKEY")))
	if e != nil {
		c.JSON(500, gin.H{
			"message": "something wrong happened while create jwt",
		})
	}
	authToken := models.Auth{
		ExpiredAt: expiryDate,
		UserID:    user.ID,
		Token:     tokenStr,
	}
	models.DB.Create(&authToken)
	c.JSON(http.StatusOK, gin.H{
		"user":  user,
		"token": tokenStr,
	})
}

type LoginBody struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

// Login godoc
// @Summary Login.
// @Description Add New User.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body LoginBody true "Inputan yang benar"
// @Success 200 {string} Login
// @Router /v1/login [post]
func Login(c *gin.Context) {
	var data LoginBody

	if err := c.ShouldBindJSON(&data); err != nil {
		c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
		return
	}

	var user models.User

	models.DB.Where("email = ?", data.Email).First(&user)

	if user.ID == 0 {
		c.JSON(http.StatusNotFound, gin.H{
			"message": "user not found",
		})
		return
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(data.Password)); err != nil {
		c.JSON(http.StatusForbidden, gin.H{
			"message": "incorrect password",
		})
		return
	}

	var token models.Auth
	err := models.DB.Where("user_id = ?", user.ID).First(&token)
	expiryDate := time.Now().AddDate(0, 0, 10)
	jwtToken := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"expire":    expiryDate,
		"userId":    user.ID,
		"userEmail": user.Email,
		"userPhone": user.Phone,
		"userName":  user.Name,
	})
	tokenStr, e := jwtToken.SignedString([]byte(getenv("JWTKEY")))
	if e != nil {
		c.JSON(500, gin.H{
			"message": "something wrong happened while create jwt",
		})
	}

	if err == nil {
		token.ExpiredAt = expiryDate
		token.Token = tokenStr
		models.DB.Updates(&token)
	} else {
		authToken := models.Auth{
			ExpiredAt: expiryDate,
			UserID:    user.ID,
			Token:     tokenStr,
		}
		models.DB.Create(&authToken)
	}

	c.JSON(http.StatusOK, gin.H{
		"user":   user,
		"token":  tokenStr,
		"expire": expiryDate,
	})

}

// UserInfo godoc
// @Summary UserInfo.
// @Description Add New User.
// @Tags authentication
// @Accept */*
// @Produce json
// @Success 200 {string} UserInfo
// @Router /v1/self [get]
func UserInfo(c *gin.Context) {
	usr := c.MustGet("user").(models.User)
	var user models.User
	err := models.DB.Where("email = ?", usr.Email).First(&user).Error
	if err == nil {
		c.JSON(http.StatusOK, user)
	} else {
		c.JSON(http.StatusNotFound, utils.ExceptionResponse("Gagal mendapat user"))
	}
}

// GetUserNameById godoc
// @Summary GetUserNameById.
// @Description GetUserById.
// @Tags authentication
// @Accept */*
// @Produce json
// @Success 200 {string} GetUserNameById
// @Router /v1/self [get]
func GetUserNameById(c *gin.Context) {
	var user models.User
	err := models.DB.Where("id = ?", c.Param("id")).First(&user).Error
	if err == nil {
		c.JSON(http.StatusOK, user)
	} else {
		c.JSON(http.StatusNotFound, utils.ExceptionResponse("Gagal mendapat user"))
	}
}

func GetAllUser(c *gin.Context) {
	var user []models.User
	if err := models.DB.Where("1 = 1").Find(&user).Error; err != nil {
		_ = c.AbortWithError(500, err)
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil get all user",
		"data":    user,
	})
}

func DeleteUser(c *gin.Context) {
	var user models.User
	err := models.DB.Where("id = ?", c.Param("id")).First(&user).Error
	if err == nil {
		err = models.DB.Delete(&user).Error
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"message": "gagal delete",
			})
		} else {
			c.JSON(http.StatusOK, gin.H{
				"message": "berhasil delete",
			})
		}
	} else {
		c.JSON(http.StatusNotFound, utils.ExceptionResponse("Gagal mendapat user"))
	}
}
