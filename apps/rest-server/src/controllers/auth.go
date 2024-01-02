package controllers

import (
	_ "fmt"

	_ "github.com/iris-contrib/middleware/jwt"
	"github.com/kataras/iris/v12"
)

func (c *AdminController) Install(ctx iris.Context) {
	//user, err := c.ServiceProvider.UserSvc.CreateAdmin("aldo", "aldo@aldoapp.com", "08112121", "willamette")
	err := c.ServiceProvider.UserSvc.ActivateUsers()
	if err != nil {
		ctx.JSON(iris.Map{"status": 0, "message": err})
	} else {
		ctx.JSON(iris.Map{"status": 1, "message": nil})
	}
}
