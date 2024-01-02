//go:build wireinject
// +build wireinject

package main

import (
	"bacteriapp/core"
	"bacteriapp/services"

	"github.com/google/wire"
)

func InitializeServiceProvider(c *core.Config) services.ServiceProvider {
	wire.Build(NewServiceProvider, NewDBAdapter, NewUserMapper,
		NewUserService, NewAppService, NewMailerService)
	return services.ServiceProvider{}
}
