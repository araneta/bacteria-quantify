package mappers

import (
	"bacteriapp/common"
	"bacteriapp/core"
	"bacteriapp/helpers"
	"bacteriapp/model"
	"bacteriapp/query"
	"fmt"
	_ "log"
	_ "strconv"
	"strings"
)

type UserMapper struct {
	Adapter *core.DBAdapter
}

func (m *UserMapper) Find(ID int) (*model.User, error) {
	entity := new(model.User)
	result := m.Adapter.Where(`"ID" = ? `, ID).First(&entity)
	if result.RowsAffected == 0 {
		return nil, nil
	}
	return entity, nil
}
func (m *UserMapper) Create(entity *model.User) (*model.User, error) {
	err := m.Adapter.Create(entity).Error
	if err != nil {
		return entity, err
	}
	return entity, nil
}

func (m *UserMapper) Update(entity *model.User) (*model.User, error) {
	err := m.Adapter.Update(entity).Error
	if err != nil {
		return entity, err
	}
	return entity, nil
}
func (m *UserMapper) Delete(entity *model.User) (*model.User, error) {
	err := m.Adapter.Delete(&entity).Error
	if err != nil {
		return entity, err
	}
	return entity, nil
}
func (m *UserMapper) FindByEmail(email string) (*model.User, error) {
	fmt.Printf("%v", email)
	u := query.User
	item, errItem := query.User.Where(
		u.Email.Eq(email),
	).First()
	if errItem != nil && errItem.Error() != "record not found" {
		return nil, errItem
	}
	return item, nil
}
func (m *UserMapper) FindAll() ([]model.User, error) {
	var users []model.User
	result := m.Adapter.Find(&users)
	if result.RowsAffected == 0 {
		return nil, nil
	}
	return users, nil
}
func (m *UserMapper) FindByForgottenPasswordCode(code string) (*model.User, error) {
	user := new(model.User)
	result := m.Adapter.Where("\"forgottenPasswordCode\" = ? ", code).First(&user)
	if result.RowsAffected == 0 {
		return nil, nil
	}
	return user, nil
}

func (m *UserMapper) SearchUsers(paging *common.Paging) (*common.PagingResult, error) {
	result := new(common.PagingResult)
	filter1 := paging.GetFilter()
	filter := "%" + strings.ToLower(filter1) + "%"
	var t1 model.User
	tbl1 := helpers.FixTableName(t1.TableName())
	helper := helpers.NewPagingHelper(tbl1, paging)
	//add filter
	p1 := "filterx"
	helper.AddWhere("and (\"IsActive\" is null or \"IsActive\"=true) AND LOWER(\"FullName\") LIKE @" + p1)
	helper.AddFilter(p1, filter)

	helper.Generate()
	query := helper.GetDataQuery()
	prms := helper.GetParameters()

	fmt.Println("quer" + query)
	fmt.Println("filete" + filter)
	rowsx, err := m.Adapter.Raw(query, prms).Rows()
	//fmt.Printf("%v", rows)
	defer rowsx.Close()

	if err == nil {
		//fmt.Println("dasdasd")

		var rows []interface{}
		for rowsx.Next() {
			var row model.User
			m.Adapter.ScanRows(rowsx, &row)
			rows = append(rows, row)
		}
		result.SetData(rows)

		//total
		var c int
		m.Adapter.Raw(helper.GetCountQuery(), prms).Scan(&c)

		result.SetTotalRecords(c)
		result.Calculate(paging)
		//fmt.Printf("%v", result)

		return result, nil
	} else {
		fmt.Printf("%v", err)
		return result, err
	}

}
