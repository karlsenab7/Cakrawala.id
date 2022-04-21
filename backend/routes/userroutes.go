package routes

import (
	"cakrawala.id/m/controllers"
	"cakrawala.id/m/controllers/transactions"
	"cakrawala.id/m/middleware"
	"github.com/gin-gonic/gin"
)

func userRoutes(e *gin.Engine) {
	gr := e.Group("/v1")
	{
		gr.POST("/register", controllers.Register)
		gr.POST("/login", controllers.Login)
		gr.GET("/test", middleware.IsAuthrorized(), func(context *gin.Context) {
			context.JSON(200, gin.H{
				"message": "tampan dan pemberani",
			})
		})
		gr.GET("/self", middleware.IsAuthrorized(), controllers.UserInfo)

		gr.POST("/top-up", middleware.IsAuthrorized(), transactions.TopUpRequest)
		gr.GET("/transaction-history", middleware.IsAuthrorized(), transactions.GetTransactionHistoryUser)

		gr.GET("/merchant", middleware.IsAuthrorized(), transactions.GetAllMerchantsUser)

		gr.POST("/pay-merchant", middleware.IsAuthrorized(), transactions.PaymentController)
		gr.POST("/pay-calculate-points", middleware.IsAuthrorized(), transactions.BonusCheckController)
		
		gr.POST("/transfer", middleware.IsAuthrorized(), transactions.Transfer)
		gr.POST("/phone-number", middleware.IsAuthrorized(), transactions.IsPhoneNumberValid)

		gr.POST("/exchange-reward", middleware.IsAuthrorized(), transactions.ExchangeReward)
		gr.GET("/get-rewards", middleware.IsAuthrorized(), transactions.GetAllRewards)
	}
}
