package dto

type HistoryDetailForm struct {
	ID          int    `json:"ID, omitempty"`
	Species     string `json:"species"`
	TotalColony int    `json:"totalColony"`
}

type HistoryEntryForm struct {
	ID                int                 `json:"ID, omitempty"`
	SampleName        string              `json:"sampleName"`
	LocalFileImage    string              `json:"localFileImage"`
	HistoryDetailForm []HistoryDetailForm `json:"details"`
}
