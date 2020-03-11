package api

import (
	"net/http"

	"github.com/labstack/echo"
)

func HelloWorld(c echo.Context) error {
	return c.JSON(http.StatusOK, "hello world")
}
