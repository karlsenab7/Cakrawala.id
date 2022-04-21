package models

import "time"

type Auth struct {
	ID        uint      `gorm:"primary_key;auto_increment" json:"id"`
	Token     string    `gorm: "not_null"`
	ExpiredAt time.Time `gorm: "not_null" json:"expiredAt"`
	UserID    uint      `gorm:"column:user_id"`
	User      User
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
}
