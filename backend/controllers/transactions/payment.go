package transactions

import (
	"cakrawala.id/m/models"
	"cakrawala.id/m/service"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
	"net/http"
)

type PayBody struct {
	MerchantId  uint   `json:"merchant_id"`
	Amount      uint64 `json:"amount"`
	Address     string `json:"address"`
	BankAccount string `json:"bankAccount"`
}

type BonusCheckerBody struct {
	Amount uint64 `json:"amount"`
}

// PaymentController godoc
// @Summary PaymentController.
// @Description Payment into merchant.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body PayBody true "Inputan yang benar"
// @Success 200 {string} PaymentController
// @Router /v1/pay-merchant [post]
func PaymentController(c *gin.Context) {
	user := c.MustGet("user").(models.User)
	var body PayBody
	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}
	bonus := service.PaymentBonusService(user, body.Amount)

	if user.Balance < body.Amount {
		c.AbortWithStatusJSON(400, gin.H{
			"message": "insufficient balance",
		})
		return
	}

	transaksi := models.Transaksi{
		Amount:     body.Amount,
		Exp:        uint32(bonus),
		Cashback:   uint32(float64(uint64(service.GetUserLevelService(user)+2)) / float64(100) * float64(body.Amount)),
		UserID:     user.ID,
		MerchantID: &body.MerchantId,
		FriendID:   nil,
		Status:     "completed",
	}

	user.Balance -= (body.Amount - uint64(transaksi.Cashback))
	user.Exp += uint32(bonus)
	user.Point += uint32(bonus)

	err := models.DB.Transaction(func(tx *gorm.DB) error {
		if e := tx.Save(&transaksi).Error; e != nil {
			return e
		}
		if e := tx.Updates(&user).Error; e != nil {
			return e
		}
		return nil
	})

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"message": "berhasil  melakukan pembayaran di merchant",
			"data":    transaksi,
		})
	} else {
		_ = c.AbortWithError(500, err)
	}

}

// BonusCheckController godoc
// @Summary BonusCheckController.
// @Description Check estimation user cashback from payment to merchant.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body BonusCheckerBody true "Inputan yang benar"
// @Success 200 {string} BonusCheckController
// @Router /v1/pay-calculate-points [post]
func BonusCheckController(c *gin.Context) {
	user := c.MustGet("user").(models.User)
	var body BonusCheckerBody
	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}
	bonus := service.PaymentBonusService(user, body.Amount)
	c.JSON(http.StatusOK, gin.H{
		"points":   bonus,
		"cashback": float64(uint64(service.GetUserLevelService(user)+2)) / float64(100) * float64(body.Amount),
	})
}
