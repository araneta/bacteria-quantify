package controllers

import (
	"bacteriapp/common"
	"bacteriapp/dto"
	"fmt"
	"path/filepath"
	"strconv"

	"github.com/iris-contrib/middleware/jwt"
	"github.com/kataras/iris/v12"
	"github.com/satori/go.uuid"
)

func (c *UserController) Login(ctx iris.Context) {
	var form LoginForm
	fmt.Println("login")
	err := ctx.ReadBody(&form)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest,
			iris.NewProblem().Title("Parser issue").Detail(err.Error()))
		return
	}
	user, err := c.ServiceProvider.UserSvc.Login(form.Username, form.Password, ctx.RemoteAddr())
	if err != nil {
		ctx.StopWithError(iris.StatusBadRequest, err)
		return
	}
	if user == nil {
		//ctx.StopWithText(iris.StatusBadRequest, result)
		//ctx.StatusCode(iris.StatusBadRequest)
		ctx.JSON(iris.Map{"status": 0, "message": "Failed to authenticate"})
		return
	}
	var respond LoginRespond
	token := jwt.NewTokenWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"username": form.Username,
		"userID":   user.ID,
		//"roleID":   user.Role,
	})

	// Sign and get the complete encoded token as a string using the secret
	tokenString, _ := token.SignedString([]byte(common.Secret))
	respond.Username = form.Username
	respond.AuthToken = tokenString
	respond.FullName = user.FullName

	//respond.RoleID = user.Role
	//respond.MobileNo = user.MobileNo
	//respond.AvatarFile = user.AvatarFile

	ctx.JSON(respond)

}
func (c *UserController) Verify(ctx iris.Context) {
	var respond CommonRespond
	respond.Status = 1
	respond.Message = "OK"
	ctx.JSON(respond)

}

func (c *UserController) ResetPassword(ctx iris.Context) {
	fmt.Printf("ResetPassword: %v\n", "1")
	var form dto.ResetPasswordForm

	err := ctx.ReadBody(&form)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest,
			iris.NewProblem().Title("Parser issue").Detail(err.Error()))
		return
	}
	localuser, errUser := c.ServiceProvider.UserSvc.FindByEmail(form.Email)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}
	var respond CommonRespond2
	respond.Status = 1

	//save the image id / avatar
	updatedUser, errUpdate := c.ServiceProvider.UserSvc.ResetPassword(int(localuser.ID), form.Email)

	if errUpdate != nil {
		respond.Status = 0
		respond.Message = errUpdate.Error()
		ctx.JSON(respond)
		return
	}

	respond.Message = updatedUser

	ctx.JSON(respond)
}

func (c *UserController) UploadAvatar(ctx iris.Context) {
	user := ctx.Values().Get("jwt").(*jwt.Token)

	//ctx.Writef("This is an authenticated request\n")
	//ctx.Writef("Claim content:\n")

	payload := user.Claims.(jwt.MapClaims)
	//log.Println("user" + foobar["user"].(string))
	email := payload["user"].(string)
	if email == "" {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Email is empty"))
	}
	localuser, errUser := c.ServiceProvider.UserSvc.FindByEmail(email)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}

	var respond CommonRespond2
	respond.Status = 1

	// single file
	file, fileHeader, err := ctx.FormFile("file")
	if err != nil {
		ctx.StopWithError(iris.StatusBadRequest, err)
		return
	}
	defer file.Close()

	uuid := uuid.NewV4().String()
	// Upload the file to specific destination.
	localFile := uuid + ".jpg"

	dest := filepath.Join(c.UserImagesPath, localFile)
	_, errsave := ctx.SaveFormFile(fileHeader, dest)
	if errsave != nil {
		//panic(err)
		respond.Status = 0
		respond.Message = errsave.Error()
		ctx.JSON(respond)
		return
	}

	//save the image id / avatar
	/*updatedUser, errUpdate := c.ServiceProvider.UserSvc.UpdateAvatar(localuser.ID, uuid)

	if errUpdate != nil {
		respond.Status = 0
		respond.Message = errUpdate.Error()
		ctx.JSON(respond)
		return
	}*/

	respond.Message = localuser

	ctx.JSON(respond)
}

func (c *UserController) UpdateProfile(ctx iris.Context) {
	user := ctx.Values().Get("jwt").(*jwt.Token)

	//ctx.Writef("This is an authenticated request\n")
	//ctx.Writef("Claim content:\n")

	payload := user.Claims.(jwt.MapClaims)
	userID := int(payload["userID"].(float64))

	localuser, errUser := c.ServiceProvider.UserSvc.Find(userID)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}
	var form dto.UpdateProfileForm

	err := ctx.ReadBody(&form)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest,
			iris.NewProblem().Title("Parser issue").Detail(err.Error()))
		return
	}

	var respond CommonRespond2
	respond.Status = 1

	//save the image id / avatar
	updatedUser, errUpdate := c.ServiceProvider.UserSvc.UpdateProfile(int(localuser.ID), &form)

	if errUpdate != nil {
		respond.Status = 0
		respond.Message = errUpdate.Error()
		ctx.JSON(respond)
		return
	}

	respond.Message = updatedUser

	ctx.JSON(respond)
}

func (c *UserController) GetProfile(ctx iris.Context) {
	user := ctx.Values().Get("jwt").(*jwt.Token)

	//ctx.Writef("This is an authenticated request\n")
	//ctx.Writef("Claim content:\n")

	payload := user.Claims.(jwt.MapClaims)
	userID := int(payload["userID"].(float64))

	localuser, errUser := c.ServiceProvider.UserSvc.Find(userID)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}
	var form dto.UpdateProfileForm
	form.Email = localuser.Email
	//form.MobileNo = localuser.MobileNo
	form.FullName = localuser.FullName

	var respond CommonRespond2
	respond.Status = 1
	respond.Message = form

	ctx.JSON(respond)
}

func (c *UserController) SaveHistory(ctx iris.Context) {
	user := ctx.Values().Get("jwt").(*jwt.Token)

	//ctx.Writef("This is an authenticated request\n")
	//ctx.Writef("Claim content:\n")

	payload := user.Claims.(jwt.MapClaims)
	userID := int(payload["userID"].(float64))

	localuser, errUser := c.ServiceProvider.UserSvc.Find(userID)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}
	var form dto.HistoryEntryForm

	err := ctx.ReadBody(&form)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest,
			iris.NewProblem().Title("Parser issue").Detail(err.Error()))
		return
	}
	// upload single file
	var respond CommonRespond2

	respond.Status = 1

	//save the image id / avatar
	updatedUser, errUpdate := c.ServiceProvider.AppSvc.SaveHistory(int(localuser.ID), &form)

	if errUpdate != nil {
		respond.Status = 0
		respond.Message = errUpdate.Error()
		ctx.JSON(respond)
		return
	}

	respond.Message = updatedUser

	ctx.JSON(respond)
}

func (c *UserController) GetHistories(ctx iris.Context) {
	user := ctx.Values().Get("jwt").(*jwt.Token)

	//ctx.Writef("This is an authenticated request\n")
	//ctx.Writef("Claim content:\n")

	payload := user.Claims.(jwt.MapClaims)
	userID := int(payload["userID"].(float64))

	_, errUser := c.ServiceProvider.UserSvc.Find(userID)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}
	//var respond CommonRespond2

	//respond.Status = 1
	result, err := c.ServiceProvider.AppSvc.GetHistories(userID)
	//respond.Message = result
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(err))

		return
	} else {
		ctx.JSON(iris.Map{"status": "1", "message": result})
	}
}

func (c *UserController) UploadDetect(ctx iris.Context) {
	user := ctx.Values().Get("jwt").(*jwt.Token)
	payload := user.Claims.(jwt.MapClaims)
	userID := int(payload["userID"].(float64))

	_, errUser := c.ServiceProvider.UserSvc.Find(userID)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}

	var respond CommonRespond2
	respond.Status = 1

	// single file
	file, fileHeader, err := ctx.FormFile("file")
	if err != nil {
		ctx.StopWithError(iris.StatusBadRequest, err)
		return
	}
	defer file.Close()

	uuid := uuid.NewV4().String()
	// Upload the file to specific destination.
	localFile := uuid + ".jpg"

	dest := filepath.Join(c.UserImagesPath, localFile)
	_, errsave := ctx.SaveFormFile(fileHeader, dest)
	if errsave != nil {
		//panic(err)
		respond.Status = 0
		respond.Message = errsave.Error()
		return
	}
	//image recognition
	details, errdetect := c.ServiceProvider.AppSvc.DetectBacteries(uuid)

	if errdetect != nil {
		respond.Status = 0
		respond.Message = errdetect.Error()
		return
	}
	var result dto.DetectionResult
	result.ImageID = uuid
	result.Bacteries = details

	respond.Message = result

	ctx.JSON(respond)
}

func (c *UserController) GetDetailHistory(ctx iris.Context) {
	user := ctx.Values().Get("jwt").(*jwt.Token)

	payload := user.Claims.(jwt.MapClaims)
	userID := int(payload["userID"].(float64))

	_, errUser := c.ServiceProvider.UserSvc.Find(userID)
	if errUser != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(errUser))

		return
	}
	sID := ctx.Params().Get("ID")
	ID, err := strconv.Atoi(sID)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Conversion error").DetailErr(err))
		return
	}
	//var respond CommonRespond2

	//respond.Status = 1
	result, err := c.ServiceProvider.AppSvc.GetDetailHistory(userID, ID)
	//respond.Message = result
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(err))

		return
	} else {
		ctx.JSON(iris.Map{"status": "1", "message": result})
	}
}
