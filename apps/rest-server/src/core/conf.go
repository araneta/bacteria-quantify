package core

import (
	"io/ioutil"
	"log"
	"os"
	"strconv"

	"gopkg.in/yaml.v2"
)

type Config struct {
	Port           string `yaml:"Port"`
	UserImagesPath string `yaml:"UserImagesPath"`
	PublicURL      string `yaml:"PublicURL"`

	DBHost     string `yaml:"DBHost"`
	DBPort     int    `yaml:"DBPort"`
	DBUsername string `yaml:"DBUsername"`
	DBPassword string `yaml:"DBPassword"`
	DBName     string `yaml:"DBName"`
	DBSchema   string `yaml:"DBSchema"`

	TimeZone string `yaml:"TimeZone"`

	SMTPHost     string `yaml:"SMTPHost"`
	SMTPPort     int    `yaml:"SMTPPort"`
	SMTPUsername string `yaml:"SMTPUsername"`
	SMTPPassword string `yaml:"SMTPPassword"`

	CallbackURL string `yaml:"CallbackURL"`
}

func (c *Config) GetConf() *Config {
	var err error
	var yamlFile []byte

	if _, err := os.Stat("iris.local.yml"); err == nil {
		log.Println("using configuration from iris.local.yml")
		yamlFile, err = ioutil.ReadFile("iris.local.yml")
	} else if _, err := os.Stat("iris.yml"); err == nil {
		log.Println("using configuration from iris.yml")
		yamlFile, err = ioutil.ReadFile("iris.yml")
	} else {
		log.Println("using configuration from environment variables")
		c.UserImagesPath = os.Getenv("UserImagesPath")

		c.DBHost = os.Getenv("DBHost")
		intPort, errPort := strconv.Atoi(os.Getenv("DBPort"))
		if errPort == nil {
			c.DBPort = intPort
		}

		c.DBUsername = os.Getenv("DBUsername")
		c.DBPassword = os.Getenv("DBPassword")
		c.DBName = os.Getenv("DBName")
		c.DBSchema = os.Getenv("DBSchema")

		c.TimeZone = os.Getenv("TimeZone")

		c.SMTPHost = os.Getenv("SMTPHost")

		intSMTPPort, errSMTPPort := strconv.Atoi(os.Getenv("SMTPPort"))
		if errSMTPPort == nil {
			c.SMTPPort = intSMTPPort
		}
		c.SMTPUsername = os.Getenv("SMTPUsername")
		c.SMTPPassword = os.Getenv("SMTPPassword")

		c.PublicURL = os.Getenv("PublicURL")
	}
	if len(yamlFile) > 0 {
		err = yaml.Unmarshal(yamlFile, c)
		if err != nil {
			log.Fatalf("Unmarshal: %v", err)
		}
	}

	return c
}
