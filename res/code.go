package res

import "net/http"

// Common: basic errors, must less than 1000.
const (
	CodeSuccess    uint32 = 0
	CodeUnknownErr uint32 = 500
)

var (
	ErrSuccess = &ErrCode{Status: http.StatusOK, Code: CodeSuccess, Msg: ""}
	ErrUnknown = &ErrCode{Status: http.StatusInternalServerError, Code: CodeUnknownErr, Msg: "系统异常，请稍后再试"}
)
