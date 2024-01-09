package services

import (
	"bacteriapp/core"
	"bacteriapp/dto"
	_ "bacteriapp/helpers"
	"bacteriapp/model"
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

	"github.com/jinzhu/copier"

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
	MailerSvc      *core.MailerService
	UserSvc        *UserService
	Config         *core.Config
	TeloService    *TeloService
	PohongService  *PohongService
	KejuService    *KejuService
	HistoryService *KejuService
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
func (s *AppService) SaveHistory(UserID int, form *dto.HistoryEntryForm) (*model.History, error) {
	var entity = new(model.History)
	//set new fields
	copier.Copy(entity, &form)
	entity.UserID = int32(UserID)
	errCreate := query.History.Create(entity)
	if errCreate != nil {
		return nil, errCreate
	}
	//save details
	for _, item := range form.HistoryDetailForm {
		var entitydetail = new(model.HistoryDetail)
		entitydetail.HistoryID = entity.ID
		entitydetail.Species = item.Species
		entitydetail.TotalColony = int32(item.TotalColony)
		errCreate1 := query.HistoryDetail.Create(entitydetail)
		if errCreate1 != nil {
			return nil, errCreate1
		}
	}
	return entity, nil

}
func (s *AppService) GetHistories(UserID int) ([]*model.History, error) {
	u := query.History
	entities, err := query.History.Where(u.UserID.Eq(int32(UserID))).Order(u.ID.Desc()).Find()
	if err != nil {
		fmt.Printf("GetHistories err\n")
		return nil, err
	}
	return entities, nil
}

func (s *AppService) GetDetailHistory(UserID int, historyID int) ([]*dto.Bacteries, error) {
	var entities []*dto.Bacteries
	h := query.History
	history, err := query.History.Where(h.ID.Eq(int32(historyID)), h.UserID.Eq(int32(UserID))).First()
	if err != nil {
		return entities, err
	}

	u := query.HistoryDetail
	rows, err1 := query.HistoryDetail.Where(u.HistoryID.Eq(history.ID)).Order(u.ID.Asc()).Find()
	if err1 != nil {
		fmt.Printf("GetHistories err\n")
		return nil, err1
	}
	for _, row := range rows {
		var row1 = new(dto.Bacteries)
		row1.Species = row.Species
		row1.TotalColony = row.TotalColony
		entities = append(entities, row1)
	}
	return entities, nil
}

func (s *AppService) DetectBacteries(uuid string) ([]*dto.Bacteries, error) {
	var rows []*dto.Bacteries
	var row1 = new(dto.Bacteries)
	row1.Species = "Alien2"
	row1.TotalColony = 122
	rows = append(rows, row1)

	var row2 = new(dto.Bacteries)
	row2.Species = "Alie32"
	row2.TotalColony = 142
	rows = append(rows, row2)
	return rows, nil
}
