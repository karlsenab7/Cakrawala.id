package models

import "time"

type Transaksi struct {
	ID        uint      `gorm:"primary_key;auto_increment" json:"id"`
	Amount    uint64    `gorm: "not_null"`
	Exp       uint32    `gorm:"default:0"`
	Status    string    `gorm:"default:completed"`
	Cashback  uint32    `gorm:"default:0"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
	IsDebit   bool      `json:"IsDebit"`

	UserID uint `gorm:"column:user_id"`
	User   User

	MerchantID *uint `gorm:"column:merchant_id"`
	Merchant   *Merchant

	FriendID *uint `gorm:"column:friend_id"`
	Friend   *User
}

