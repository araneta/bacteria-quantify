package dto

type DetectionResult struct {
	ImageID   string       `json:"imageID, omitempty"`
	Bacteries []*Bacteries `json:"bacteries"`
}
