package dto

type UpdateProfileForm struct {
	Email    string `json:"email"  gorm:"column:email"`
	Password string `json:"password"  gorm:"column:password"`
	MobileNo string `json:"mobileNo"  gorm:"column:mobileNo"`
	FullName string `json:"fullName"  gorm:"column:fullName"`
}
