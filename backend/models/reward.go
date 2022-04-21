package models

import (
	"time"
)

type Reward struct {
	ID        uint      `gorm:"primary_key;auto_increment" json:"id"`
	Name      string    `gorm:"not_null" json:"name"`
	Price     uint32    `gorm:"not_null" json:"price"`
	Stock     int16     `gorm:"not_null" json:"stock"`
	Image     string    `gorm:"default:https://w7.pngwing.com/pngs/529/972/png-transparent-award-prize-medal-computer-icons-award-culture-trophy-symbol-thumbnail.png" json:"image"`
	CreatedAt time.Time `json:"createdAt"`
	UpdatedAt time.Time `json:"updatedAt"`

	Claims []HistoryReward `gorm:"ForeignKey:RewardID"`
}
