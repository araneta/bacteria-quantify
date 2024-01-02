package services

import (
	"crypto/md5"
	"encoding/hex"
	"errors"
	"fmt"
	_ "strconv"
	"strings"
	_ "time"

	"github.com/jinzhu/copier"

	"bacteriapp/common"
	"bacteriapp/core"
	"bacteriapp/dto"
	"bacteriapp/helpers"
	"bacteriapp/mappers"
	"bacteriapp/model"
)

func GetMD5Hash(text string) string {
	hash := md5.Sum([]byte(text))
	return hex.EncodeToString(hash[:])
}

type UserService struct {
	Mapper    *mappers.UserMapper
	MailerSvc *core.MailerService
}

func (s *UserService) Find(ID int) (*model.User, error) {
	return s.Mapper.Find(ID)
}
func (s *UserService) FindByEmail(email string) (*model.User, error) {

	return s.Mapper.FindByEmail(email)
}
func (s *UserService) OperatorLogin(usernamex, password, IPAddress string) (*model.User, error) {
	username := strings.TrimSpace(usernamex)
	user, err := s.Mapper.FindByEmail(username)
	if err != nil || user == nil {
		return nil, err
	}

	//if helpers.PasswordVerify(password, user.Password) {
	hash := GetMD5Hash(password)
	fmt.Printf("hash: %v\n", hash)
	if hash == user.Password {
		//loc, _ := time.LoadLocation("Asia/Jakarta")
		//user.LastAccess = helpers.GetCurrentTime("Asia/Jakarta")
		//user.LastLoginIPAddress = IPAddress
		fmt.Printf("ok: %v\n", hash)
		newuser, err2 := s.Mapper.Update(user)
		if err2 != nil {
			fmt.Printf("err2: %v\n", err2)
			return user, err2
		}
		fmt.Printf("ok: %v\n", newuser)
		return newuser, nil
	}
	return nil, err
}

func (s *UserService) SearchUsers(paging *common.Paging) (*common.PagingResult, error) {
	return s.Mapper.SearchUsers(paging)
}
func (s *UserService) CreateUser(fullName, email, mobileNo, password string, roleID int) (*model.User, error) {

	//find existing user with email
	user, err := s.FindByEmail(email)
	if err != nil {
		return nil, err
	}

	if user != nil {
		return nil, errors.New("Email already registered")
	}

	hashPass, err := helpers.PasswordHash(password)
	if err != nil {
		panic("Failed to generate password hash")
	}

	user2 := model.User{FullName: fullName,
		Email: email, Password: hashPass,
	}

	newUser, errNew := s.Mapper.Create(&user2)
	//remove passh hash
	if errNew == nil {
		newUser.Password = ""
	}
	return newUser, errNew
}
func (s *UserService) UpdateUser(form dto.UserEntryForm) (*model.User, error) {
	fmt.Printf("save: %v\n", form)
	user, err1 := s.Mapper.Find(form.ID)
	if err1 != nil {
		return nil, err1
	}
	fmt.Printf("user: %v\n", user)
	if user == nil {
		return nil, errors.New("User not found")
	}
	//validate email
	user2, err2 := s.FindByEmail(form.Email)
	if err2 != nil {
		return nil, err2
	}
	fmt.Printf("user2: %v\n", user2)
	if user2 != nil && user2.ID != int32(form.ID) {
		return nil, errors.New("Email already registered")
	}
	if strings.TrimSpace(form.Password) != "" {
		hashPass, errPass := helpers.PasswordHash(form.Password)
		if errPass != nil {
			panic("Failed to generate password hash")
		}
		form.Password = hashPass
	}
	//set new fields
	copier.Copy(&user, &form)
	fmt.Printf("user: %v\n", user)

	updatedUser, errUpdate := s.Mapper.Update(user)
	//remove passh hash
	if errUpdate == nil {
		updatedUser.Password = ""
	}
	return updatedUser, errUpdate
}
func (s *UserService) DeleteUser(ID int) (*model.User, error) {
	user, err1 := s.Mapper.Find(ID)
	if err1 != nil {
		return nil, err1
	}
	fmt.Printf("user: %v\n", user)
	if user == nil {
		return nil, errors.New("User not found")
	}

	//updatedUser, errUpdate := s.Mapper.Delete(user)
	//soft delete
	//user.IsActive = false

	updatedUser, errUpdate := s.Mapper.Update(user)
	//remove passh hash
	if errUpdate == nil {
		updatedUser.Password = ""
	}
	return updatedUser, errUpdate
}
func (s *UserService) ActivateUsers() error {
	users, errUsers := s.Mapper.FindAll()
	if errUsers != nil {
		return errUsers
	}
	for _, user := range users {
		//user.IsActive = true
		updatedUser, errUpdate := s.Mapper.Update(&user)
		if errUpdate == nil {
			fmt.Printf("updated user: %v", updatedUser)
		} else {
			return errUpdate
		}

	}
	return nil
}

func (s *UserService) Login(usernamex, password, IPAddress string) (*model.User, error) {
	username := strings.TrimSpace(usernamex)
	user, err := s.Mapper.FindByEmail(username)
	if err != nil {
		return nil, err
	}
	if user == nil {
		fmt.Print("user nil\n")
		return nil, nil
	}
	fmt.Printf("user: %v\n", user)

	fmt.Printf("pass: %v\n", password)
	fmt.Printf("hashpass: %v\n", user.Password)
	if helpers.PasswordVerify(password, user.Password) {
		fmt.Printf("user: %v\n", user)
		//if user.IsActive == false {
		//	fmt.Printf("inactive user: %v\n", user)
		//	return nil, nil
		//}
		//loc, _ := time.LoadLocation("Asia/Jakarta")
		//user.LastAccess = time.Now().In(loc)
		user.LastAccess = helpers.GetCurrentTime("Asia/Jakarta")
		//user.LastLoginIPAddress = IPAddress
		return s.Mapper.Update(user)
	}
	return nil, err
}

func (s *UserService) UpdateProfile(userID int, form *dto.UpdateProfileForm) (*model.User, error) {
	user, err := s.Find(userID)
	if err != nil {
		return nil, err
	}
	fmt.Printf("user: %v\n", user)
	if user == nil {
		return nil, errors.New("User not found")
	}

	//if helpers.PasswordVerify(oldPassword, user.Password) {
	var password = strings.TrimSpace(form.Password)
	fmt.Printf("password: %v\n", password)
	hashPass, err := helpers.PasswordHash(password)
	if err != nil {
		//panic("Failed to generate password hash")
		return nil, err
	}
	user.Password = hashPass
	user.Email = form.Email
	//user.MobileNo = form.MobileNo
	user.FullName = form.FullName

	return s.Mapper.Update(user)
	//} else {
	//	return nil, errors.New("Incorrect Password")
	//}
}
