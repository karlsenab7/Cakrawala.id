package transactions

import (
	"net/http"
	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
)

// GetTransactionHistoryUser godoc
// @Summary GetTransactionHistoryUser.
// @Description get history transaction by user.
// @Accept */*
// @Produce json
// @Success 200 {string} GetTransactionHistory
// @Router /admin/transaction-history-user/:id [post]
func GetTransactionHistoryUser(c *gin.Context)  {
	user := c.MustGet("user").(models.User)
	var transactionHistoryReq []models.Transaksi
	// err := models.DB.Where("user_id = ?", c.Param("id")).Find(&transactionHistoryReq).Error
	err := models.DB.Where("user_id = ?", user.ID).Find(&transactionHistoryReq).Error

	if err != nil {
		c.AbortWithError(500, err)
		return
	}
	data := transactionHistoryReq
	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil get transaction history user requests",
		"data":    data,
	})
}

func GetTransactionHistoryAdmin(c *gin.Context)  {
	
	var transactionHistoryReq []models.Transaksi
	// err := models.DB.Where("user_id = ?", c.Param("id")).Find(&transactionHistoryReq).Error
	err := models.DB.Find(&transactionHistoryReq).Error

	if err != nil {
		c.AbortWithError(500, err)
		return
	}

	data := transactionHistoryReq
	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil get transaction history admin requests",
		"data":    data,
	})
	
	
}