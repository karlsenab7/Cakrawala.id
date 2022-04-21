package models

import (
	"gorm.io/gorm"
	"time"
)

// TODO constraint not null-nya ga work?
type User struct {
	ID        uint      `gorm:"primary_key;auto_increment" json:"id"`
	Email     string    `gorm:"unique;not null" json:"email"`
	Password  string    `gorm:"not null" json:"-"`
	Name      string    `gorm:"not null"`
	Phone     string    `gorm:"not null"`
	Balance   uint64    `gorm:"default:0" json:"balance"`
	Admin     bool      `gorm:"default:false" json:"-"`
	Point     uint32    `gorm:"default:0" json:"point"`
	Exp       uint32    `gorm:"default:0" json:"exp"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`
	DeletedAt gorm.DeletedAt
	Token     []Auth          `gorm:"ForeignKey:UserID"`
	Transaksi []Transaksi     `gorm:"ForeignKey:UserID"`
	Reward    []HistoryReward `gorm:"ForeignKey:UserID"`
}
