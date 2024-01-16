package main

import (
	
	"gorm.io/gen"
	"bacteriapp/core"
)

func main() {


	var c *core.Config = new(core.Config)
	if c.GetConf() == nil {
		panic("No config")
	} else {
		

	}

	g := gen.NewGenerator(gen.Config{
		OutPath: "./query",
		Mode:    gen.WithoutContext | gen.WithDefaultQuery | gen.WithQueryInterface, // generate mode
		//Mode: gen.WithoutContext,
	})
	
	var myDb = new(core.DBAdapter)
	var db = c.Databases[0]
	myDb.Init(db.DBHost, db.DBPort, db.DBUsername, db.DBPassword, db.DBName, db.DBSchema, c.TimeZone)
	
	g.UseDB(myDb.DB) // reuse your gorm db
	g.ApplyBasic(
		// Generate structs from all tables of current database
		g.GenerateAllTable()...,
	)
	// Apply the interface to existing `User` and generated `Employee`
	//g.ApplyInterface(func(MakanDitempatQuerier) {}, g.GenerateModel("makan_ditempat"))

	// Generate the code
	g.Execute()
}


