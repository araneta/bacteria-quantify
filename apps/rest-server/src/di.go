package main

import (
	"bacteriapp/core"
	"bacteriapp/mappers"
	"bacteriapp/query"
	"bacteriapp/services"
	"fmt"
)

//app di

/*
type App struct{
	UserSvc *services.UserService

}
func NewApp(userSvc *services.UserService) App {
    return App{UserSvc: userSvc}
}
*/
func NewServiceProvider(userSvc *services.UserService, mailerSvc *core.MailerService, appSvc *services.AppService) services.ServiceProvider {
	fmt.Printf("%v", "NewServiceProvider")
	return services.ServiceProvider{UserSvc: userSvc, MailerSvc: mailerSvc, AppSvc: appSvc}
}
func NewDBAdapter(c *core.Config) *core.DBAdapter {
	fmt.Printf("%v", "NewDBAdapter")
	var myDb = new(core.DBAdapter)
	var firstDB = c.Databases[0]
	myDb.Init(firstDB.DBHost, firstDB.DBPort, firstDB.DBUsername, firstDB.DBPassword, firstDB.DBName, firstDB.DBSchema, c.TimeZone)
	query.SetDefault(myDb.DB)
	return myDb
}

//Mappers
func NewUserMapper(adapter *core.DBAdapter) *mappers.UserMapper {
	var m = new(mappers.UserMapper)
	m.Adapter = adapter
	return m
}

//services
func NewUserService(mapper *mappers.UserMapper, mailerSvc *core.MailerService) *services.UserService {
	var m = new(services.UserService)
	m.Mapper = mapper

	m.MailerSvc = mailerSvc
	return m
}

func NewAppService(c *core.Config, mailerSvc *core.MailerService, userSvc *services.UserService) *services.AppService {

	var m = new(services.AppService)
	m.Init()
	m.MailerSvc = mailerSvc
	m.UserSvc = userSvc
	m.Config = c

	return m
}

func NewMailerService(c *core.Config) *core.MailerService {
	var svc = new(core.MailerService)
	svc.Init(c.SMTPHost, c.SMTPPort, c.SMTPUsername, c.SMTPPassword)
	return svc
}
