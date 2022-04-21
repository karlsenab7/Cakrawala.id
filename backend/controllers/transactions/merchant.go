package transactions

import (
	"net/http"

	"cakrawala.id/m/utils"

	"cakrawala.id/m/models"
	"github.com/gin-gonic/gin"
)

type AddMerchantBody struct {
	Name      string `json:"name"`
	Address   string `json:"address"`
	AccountId string `json:"account_id"`
}

// AddMerchant godoc
// @Summary AddMerchant.
// @Description Add New Merchant.
// @Tags authentication
// @Accept */*
// @Produce json
// @Param data body AddMerchantBody true "Inputan yang benar"
// @Success 200 {string} AddMerchant
// @Router /admin/merchant/add [post]
func AddMerchant(c *gin.Context) {
	var data AddMerchantBody

	if err := c.ShouldBindJSON(&data); err != nil {
		c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
		return
	}

	var merchant models.Merchant

	err := models.DB.Where("account_id = ?", data.AccountId).First(&merchant).Error
	if err == nil {
		c.JSON(400, gin.H{
			"message": "account id sudah pernah dipakai",
		})
		c.Abort()
		return
	}

	merchant_add := models.Merchant{
		Name:      data.Name,
		Address:   data.Address,
		AccountId: data.AccountId,
	}

	// er := models.DB.Create(&merchant_add).Error
	// if er != nil {
	// 	_ = c.AbortWithError(500, er)
	// 	return
	// }

	models.DB.Create(&merchant_add)
	c.JSON(http.StatusOK, gin.H{
		"message":    "Merchant added",
		"name":       data.Name,
		"account_id": data.AccountId,
	})
}

// GetAllMerchantsAdmin godoc
// @Summary GetAllMerchantsAdmin.
// @Description Show All Merchants for Admin.
// @Tags authentication
// @Accept */*
// @Produce json
// @Success 200 {string} GetAllMerchantsAdmin
// @Router /admin/merchant [get]
func GetAllMerchantsAdmin(c *gin.Context) {
	var merchants []models.Merchant
	err := models.DB.Find(&merchants).Error

	if err != nil {
		c.AbortWithError(500, err)
		return
	}

	data := merchants
	c.JSON(http.StatusOK, gin.H{
		"message": "Get all merchant",
		"data":    data,
	})
}

// GetAllMerchantsUser godoc
// @Summary GetAllMerchantsUser.
// @Description Show All Merchants for User.
// @Tags authentication
// @Accept */*
// @Produce json
// @Success 200 {string} GetAllMerchantsUser
// @Router /v1/merchant [get]
func GetAllMerchantsUser(c *gin.Context) {
	var merchants []models.Merchant
	err := models.DB.Find(&merchants).Error

	if err != nil {
		c.AbortWithError(500, err)
		return
	}

	data := merchants
	c.JSON(http.StatusOK, gin.H{
		"message": "Get all merchant",
		"data":    data,
	})
}

func GetMerchantAdminById(c *gin.Context) {
	var merchant models.Merchant
	err := models.DB.Where("id = ?", c.Param("id")).First(&merchant).Error
	if err == nil {
		c.JSON(http.StatusOK, merchant)
	} else {
		c.JSON(http.StatusNotFound, utils.ExceptionResponse("Gagal mendapat merchant"))
	}
}

func DeleteMerchant(c *gin.Context) {
	var merchant models.Merchant
	err := models.DB.Where("id = ?", c.Param("id")).First(&merchant).Error
	if err == nil {
		err = models.DB.Delete(&merchant).Error
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
		c.JSON(http.StatusNotFound, utils.ExceptionResponse("Gagal mendapat merchant"))
	}
}
