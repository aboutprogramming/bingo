package res

type Response struct {
	Data any    `json:"data,omitempty"`
	Msg  string `json:"msg"`
	Code uint32 `json:"code"`
}

func NewSuccessResponse(data any) *Response {
	return &Response{
		Code: ErrSuccess.Code,
		Msg:  ErrSuccess.Msg,
		Data: data,
	}
}
