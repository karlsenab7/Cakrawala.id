package models

import "time"

type HistoryReward struct {
	id         uint      `gorm:"primaryKey;autoIncrement" `
	Quantity   uint16    `gorm: "not_null"`
	PointsPaid uint32    `gorm: "not_null"`
	CreatedAt  time.Time `json:"createdAt"`
	UpdatedAt  time.Time `json:"updatedAt"`

	UserID uint `gorm:"column:user_id"`
	User   User

	RewardID uint `gorm:"column:reward_id"`
	Reward   Reward
}
