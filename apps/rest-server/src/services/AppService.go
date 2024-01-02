package services

import (
	"bacteriapp/core"
	_ "bacteriapp/dto"

	_ "bacteriapp/helpers"
	_ "bacteriapp/model"
	"bacteriapp/query"
	_ "bytes"
	"context"
	_ "encoding/json"
	_ "errors"
	"fmt"
	_ "io"
	_ "io/ioutil"
	_ "net/http"
	_ "os"
	_ "strconv"
	_ "strings"
	"time"

	_ "github.com/satori/go.uuid"
)

var ctx = context.Background()

func fmtDuration(elapsedTime time.Duration) string {
	hours := int(elapsedTime.Hours())
	minutes := int(elapsedTime.Minutes()) % 60
	seconds := int(elapsedTime.Seconds()) % 60
	var elapsedTimeFormatted = ""
	// Format the elapsed time as "4:12:34"
	if hours > 0 {
		elapsedTimeFormatted = fmt.Sprintf("%d:%02d:%02d", hours, minutes, seconds)
	} else if minutes > 0 {
		elapsedTimeFormatted = fmt.Sprintf("%02d:%02d", minutes, seconds)
	} else if seconds > 0 {
		elapsedTimeFormatted = fmt.Sprintf("%02d s", seconds)
	}

	return elapsedTimeFormatted
}

type AppService struct {
	MailerSvc     *core.MailerService
	UserSvc       *UserService
	Config        *core.Config
	TeloService   *TeloService
	PohongService *PohongService
	KejuService   *KejuService
}

func (s *AppService) Init() {
}

func (s *AppService) Test() string {
	u := query.User
	user, err := query.User.Where(u.FullName.Eq("modi")).First()

	if err != nil {

		return "error"
	}
	return user.FullName + "OK"
	//return "OK"
}
