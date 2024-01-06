package dto

type Bacteries struct {
	ID          int    `json:"ID, omitempty"`
	Species     string `gorm:"column:species;not null;default:''::character varying;comment:NGS generated" json:"species"` // NGS generated
	TotalColony int32  `gorm:"column:totalColony;not null;comment:NGS generated" json:"totalColony"`                       // NGS generated
}
