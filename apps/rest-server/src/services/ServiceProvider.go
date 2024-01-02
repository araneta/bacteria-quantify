package services

import (
	"bacteriapp/core"
)

type ServiceProvider struct {
	UserSvc   *UserService
	MailerSvc *core.MailerService
	AppSvc    *AppService
	TeloService *TeloService
 PohongService *PohongService
 KejuService *KejuService
 
}
