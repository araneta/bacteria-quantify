package dto

type UserEntryForm struct {
	ID       int    `json:"ID, omitempty"`
	FullName string `json:"fullName"`
	Email    string `json:"email"`
	Role     int    `json:"roleID"  gorm:"column:roleID"`
	MobileNo string `json:"mobileNo"`
	Password string `json:"password"`
}
