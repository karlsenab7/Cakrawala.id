package middleware

import (
	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
	"time"
)

func IsAuthrorized() gin.HandlerFunc {
	return func(c *gin.Context) {
		token := c.GetHeader("Authorization")
		println(token)
		if token == "" {
			c.AbortWithStatusJSON(400, gin.H{
				"message": "No authorization header",
			})
			return
		}
		var auth models.Auth
		err := models.DB.Preload("User").Where("token = ?", token).First(&auth).Error
		println(auth.ID)
		if err != nil {
			c.AbortWithStatusJSON(401, gin.H{
				"message": "No token found",
			})
			return
		}

		if time.Now().Before(auth.ExpiredAt) == false {
			c.AbortWithStatusJSON(402, gin.H{
				"message": "Token Expire",
			})
			return
		}
		c.Set("user", auth.User)
		c.Next()
	}
}
