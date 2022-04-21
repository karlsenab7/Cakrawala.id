package routes

import "github.com/gin-gonic/gin"

func GetRoutes(e *gin.Engine) {
	userRoutes(e)
	adminRoutes(e)
}
