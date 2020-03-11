package main

import (
	api "helloworld/api" // 这里使用的是相对路径

	"github.com/labstack/echo"
)

func main() {
	e := echo.New()
	e.GET("/", api.HelloWorld)
	e.Logger.Fatal(e.Start(":1323"))
}
