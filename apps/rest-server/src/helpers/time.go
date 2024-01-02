package helpers

import (
	"embed"
	"time"
)

//https://stackoverflow.com/a/75809126
//go:embed zoneinfo
var zoneInfoFS embed.FS // get it from GOROOT/lib/time/zoneInfo.zip

func getLocation(name string) (loc *time.Location) {
	bs, err := zoneInfoFS.ReadFile("zoneinfo/" + name)
	if err != nil {
		panic(err)
	}
	loc, err = time.LoadLocationFromTZData(name, bs)
	if err != nil {
		panic(err)
	}
	return loc
}

func GetCurrentTime(zone string) time.Time {
	//loc, _ := time.LoadLocation("Asia/Jakarta")
	loc := getLocation(zone)
	return time.Now().In(loc)
}
