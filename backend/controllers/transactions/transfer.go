package transactions

import (
	"net/http"

	"cakrawala.id/m/models"
	"cakrawala.id/m/utils"
	"github.com/gin-gonic/gin"
)

type TransferBody struct {
	Amount 		uint64 	`json:"amount"`
	FriendID 	uint 	`json:"friend_id"`
}

func Transfer(c *gin.Context)  {
	user := c.MustGet("user").(models.User)
	var data = new(TransferBody)
	var receiver models.User

	if err := c.ShouldBind(data); err != nil {
		c.JSON(http.StatusBadRequest, utils.ErrorResponse(err))
		return
	}

	//check sender's destination
	if data.FriendID == user.ID {
		c.JSON(400, gin.H{
			"message": "The recipient cannot be the same as the sender",
		})
		c.Abort()
		return
	}

	// check receiver's account
	err := models.DB.Where("id = ?", &data.FriendID).First(&receiver).Error
	if err != nil {
		c.JSON(400, gin.H{
			"message": "Recipient doesn't exist",
		})
		c.Abort()
		return
	}

	// check sender's balance
	if uint64(user.Balance) < uint64(data.Amount) {
		c.JSON(400, gin.H{
			"message": "Insufficient balance",
		})
		c.Abort()
		return
	}

	user.Balance -= uint64(data.Amount)
	receiver.Balance += uint64(data.Amount)

	models.DB.Updates(&user)
	models.DB.Updates(&receiver)

	// bonus := service.TransferBonus(user, int64(data.Amount))
	transaction_sender := models.Transaksi{
		Amount: data.Amount,
		Exp: uint32(10),
		Cashback: uint32(0),
		UserID: user.ID,
		MerchantID: nil,
		FriendID: &data.FriendID,
		IsDebit: true,
	}

	err = models.DB.Create(&transaction_sender).Error
	if err != nil {
		_ = c.AbortWithError(500, err)
		return
	}

	transaction_receiver := models.Transaksi{
		Amount: data.Amount,
		Exp: uint32(10),
		Cashback: uint32(0),
		UserID: data.FriendID,
		MerchantID: nil,
		FriendID: &user.ID,
		IsDebit: false,
	}

	err = models.DB.Create(&transaction_receiver).Error
	if err != nil {
		_ = c.AbortWithError(500, err)
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Transfer success",
	})
}

type PhoneNumberBody struct {
	Phone 		string 	`json:"phone"`
}

func IsPhoneNumberValid (c *gin.Context) {
	var body PhoneNumberBody
	var users[] models.User;

	if err := c.BindJSON(&body); err != nil {
		c.AbortWithError(400, err)
		return
	}

	print(body.Phone)

	models.DB.Where("phone = ?", body.Phone).Find(&users)
	
	if len(users) == 0 {
		c.JSON(400, gin.H{
			"message": "The user with that phone number cannot be found",
		})
		c.Abort()
		return
	}

	data := users
	c.JSON(http.StatusOK, gin.H{
		"message": "Get all users by phone number",
		"data":    data,
	})
}