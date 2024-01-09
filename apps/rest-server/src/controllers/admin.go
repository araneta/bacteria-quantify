package controllers

import (
	"bacteriapp/common"
	"bacteriapp/dto"
	"path/filepath"
	"strconv"

	"github.com/kataras/iris/v12"
	"github.com/satori/go.uuid"
)

func (c *AdminController) Test(ctx iris.Context) {
	ctx.JSON(iris.Map{"status": "1", "message": ""})
}

func (c *AdminController) SearchUsers(ctx iris.Context) {
	var page common.Paging
	page.Init()
	page.SetValidColumns([]string{"ID", "CreatedAt"})
	page.BindRequest(ctx)
	page.Validate()

	result, err := c.ServiceProvider.UserSvc.SearchUsers(&page)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Search error").DetailErr(err))

		return
	} else {
		ctx.JSON(iris.Map{"status": "1", "message": result})
	}
}
func (c *AdminController) AddUser(ctx iris.Context) {

	var form dto.UserEntryForm

	err := ctx.ReadBody(&form)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest,
			iris.NewProblem().Title("Parser issue").Detail(err.Error()))
		return
	}
	//var respond CommonRespond

	user, err := c.ServiceProvider.UserSvc.CreateUser(form.FullName, form.Email, form.MobileNo, form.Password)

	if err != nil {
		ctx.JSON(iris.Map{"status": 0, "message": err})
	} else {
		ctx.JSON(iris.Map{"status": 1, "message": user})
	}

}
func (c *AdminController) GetUser(ctx iris.Context) {
	sID := ctx.Params().Get("ID")
	ID, err := strconv.Atoi(sID)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Conversion error").DetailErr(err))
		return
	}

	result, err := c.ServiceProvider.UserSvc.Find(ID)
	if err != nil {
		ctx.StopWithProblem(iris.StatusBadRequest, iris.NewProblem().
			Title("Not found").DetailErr(err))

		return
	} else {
		ctx.JSON(iris.Map{"status": "1", "message": result})
	}
}

func (c *AdminController) UpdateUser(ctx iris.Context) {
	sID := ctx.Params().Get("ID")

	ID, err := strconv.Atoi(sID)
	if err != nil {
		ctx.StopWithError(iris.StatusBadRequest, err)
		return
	}

	var form dto.UserEntryForm

	err1 := ctx.ReadBody(&form)
	if err1 != nil {
		ctx.StopWithProblem(iris.StatusBadRequest,
			iris.NewProblem().Title("Parser issue").Detail(err1.Error()))
		return
	}
	form.ID = ID
	//var respond CommonRespond

	user, err2 := c.ServiceProvider.UserSvc.UpdateUser(form)

	if err2 != nil {
		ctx.JSON(iris.Map{"status": 0, "message": err2})
	} else {
		ctx.JSON(iris.Map{"status": 1, "message": user})
	}

}

func (c *AdminController) DeleteUser(ctx iris.Context) {
	sID := ctx.Params().Get("ID")

	ID, err := strconv.Atoi(sID)
	if err != nil {
		ctx.StopWithError(iris.StatusBadRequest, err)
		return
	}

	user, err2 := c.ServiceProvider.UserSvc.DeleteUser(ID)

	if err2 != nil {
		ctx.JSON(iris.Map{"status": 0, "message": err2})
	} else {
		ctx.JSON(iris.Map{"status": 1, "message": user})
	}

}

func (c *AdminController) UploadFile(ctx iris.Context) {
	ext := ctx.Params().Get("ext")
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
	localFile := uuid + "." + ext

	dest := filepath.Join(c.UserImagesPath, localFile)
	_, errsave := ctx.SaveFormFile(fileHeader, dest)
	if errsave != nil {
		//panic(err)
		respond.Status = 0
		respond.Message = errsave.Error()
		return
	}

	respond.Status = 1
	respond.Message = localFile

	ctx.JSON(respond)
}

func (c *AdminController) GetFile(ctx iris.Context) {
	sID := ctx.Params().Get("ID")
	fileName := ctx.Params().Get("fileName")

	src := filepath.Join(c.UserImagesPath, sID)

	ctx.SendFile(src, fileName)

}
