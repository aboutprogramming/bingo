package res

import (
	"context"

	"github.com/pkg/errors"
)

func ErrorHandlerCtx(ctx context.Context, err error) (status int, response any) {
	var errCode *ErrCode
	if errors.As(errors.Cause(err), &errCode) {
		return errCode.Status, Response{
			Data: nil,
			Msg:  errCode.Msg,
			Code: errCode.Code,
		}
	}
	return ErrUnknown.Status, Response{
		Data: nil,
		Msg:  ErrUnknown.Msg,
		Code: ErrUnknown.Code,
	}
}
