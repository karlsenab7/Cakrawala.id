package transactions

import (
	"net/http"

	"cakrawala.id/m/models"
	"cakrawala.id/m/service"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type TopUpBody struct {
	Amount uint64 `json:"amount"`
}

// TopUpRequest Login godoc
// @Summary TopUpRequest.
// @Description Add New User.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body TopUpBody true "Inputan yang benar"
// @Success 200 {string} Login
// @Router /v1/top-up [post]
func TopUpRequest(c *gin.Context) {
	user := c.MustGet("user").(models.User)
	var body TopUpBody
	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}

	bonus := service.TopUpBonusService(user, int64(body.Amount))
	transaksi := models.Transaksi{
		Amount:     body.Amount,
		Exp:        uint32(bonus),
		Cashback:   0,
		UserID:     user.ID,
		MerchantID: nil,
		FriendID:   nil,
		Status:     "pending",
		User:       user,
	}
	e := models.DB.Create(&transaksi).Error
	if e != nil {
		c.AbortWithStatus(500)
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil request topup",
		"data":    transaksi,
	})

}

func ApproveTopUp(c *gin.Context) {
	//Cek apakah ada topup dengan id itu
	var transaksi models.Transaksi
	e := models.DB.Preload("User").Where("id = ? AND status != 'completed'", c.Param("id")).First(&transaksi).Error
	if e != nil {
		c.AbortWithStatusJSON(404, gin.H{
			"message": "request topup tidak ditemukan",
		})
		return
	}
	//Ubah Status
	transaksi.Status = "completed"
	//Jika di terima maka masukkan saldo ke user
	transaksi.User.Balance += transaksi.Amount
	transaksi.User.Exp += transaksi.Exp
	transaksi.User.Point += transaksi.Exp

	err := models.DB.Transaction(func(tx *gorm.DB) error {
		if e := tx.Updates(&transaksi).Error; e != nil {
			return e
		}
		if e := tx.Updates(&transaksi.User).Error; e != nil {
			return e
		}
		return nil
	})

	if err != nil {
		c.AbortWithError(500, e)
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Berhasil accept saldo",
		"data":    transaksi,
	})
}

func GetTopUpRequest(c *gin.Context) {
	var topupReq []models.Transaksi
	err := models.DB.Preload("User").Where("merchant_id IS NULL AND friend_id IS NULL AND status != 'completed'").Find(&topupReq).Error
	if err != nil {
		c.AbortWithError(500, err)
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"message": "berhasil get top up requests",
		"data":    topupReq,
	})
}
