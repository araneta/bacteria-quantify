package helpers

import (
	"bacteriapp/common"
	"bytes"
	_ "encoding/json"
	"fmt"
	"strings"
	"unicode"
)

func HasUpperCase(word string) bool {
	for _, r := range word {
		if unicode.IsUpper(r) {
			return true
		}
	}
	return false
}
func FixTableName(tableName string) string {
	if HasUpperCase(tableName) {
		return `"` + tableName + `"`
	}
	return tableName
}

type PagingHelper struct {
	table      string
	paging     *common.Paging
	countQuery string
	dataQuery  string
	cols       string
	addWhere   string
	addJoin    string
	prm        map[string]interface{}
}

func NewPagingHelper(table string, paging *common.Paging) *PagingHelper {

	return &PagingHelper{
		table:  table,
		cols:   "*",
		paging: paging,
		prm:    make(map[string]interface{}),
	}
}

func (p *PagingHelper) GetCountQuery() string {

	return p.countQuery

}

func (p *PagingHelper) GetDataQuery() string {

	return p.dataQuery

}

func (p *PagingHelper) GetParameters() map[string]interface{} {
	return p.prm
}

func (p *PagingHelper) AddFilter(name string, value interface{}) {

	p.prm[strings.ReplaceAll(name, "@", "")] = value
}

func (p *PagingHelper) AddWhere(where string) {
	p.addWhere += where
}
func (p *PagingHelper) AddJoin(table2, col1, condition, col2 string) {
	p.addJoin += fmt.Sprintf(" join %s on %s %s %s", table2, col1, condition, col2)
}

func (p *PagingHelper) AddLeftJoin(table2, col1, condition, col2 string) {
	p.addJoin += fmt.Sprintf(" left join %s on %s %s %s", table2, col1, condition, col2)
}
func (p *PagingHelper) Select(cols string) {
	p.cols = cols
}

func (p *PagingHelper) Generate() {
	order := p.paging.GetSort()
	//filters := p.prm
	table := p.table

	var sqlfilter bytes.Buffer
	fmt.Fprintf(&sqlfilter, " from %s %s where 1 = 1 %s ", table, p.addJoin, p.addWhere)

	var sql bytes.Buffer
	sql.Write(sqlfilter.Bytes())

	if order.Len() > 0 {
		sql.WriteString(" ORDER BY ")
		//for key, value := range order {
		//fmt.Fprintf(&sql, "%s %s ", key, value)
		//}
		var fieldNames []string
		for pair := order.Oldest(); pair != nil; pair = pair.Next() {
			//fmt.Fprintf(&sql, "%s %s ", pair.Key, pair.Value)
			fieldNames = append(fieldNames, fmt.Sprintf("%s %s ", pair.Key, pair.Value))
		}
		sql.WriteString(strings.Join(fieldNames, ", "))
	}
	limit := p.paging.GetPageSize()
	if limit > 0 {
		fmt.Fprintf(&sql, " LIMIT %d", limit)
	}
	offset := p.paging.GetStart()
	if offset > 0 {
		fmt.Fprintf(&sql, " OFFSET %d", offset)
	}

	p.countQuery = fmt.Sprintf("SELECT count(%s) %s", p.cols, sqlfilter.String())
	p.dataQuery = fmt.Sprintf("SELECT %s %s", p.cols, sql.String())

}
