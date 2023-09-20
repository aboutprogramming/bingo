package res

import (
	"fmt"

	"github.com/pkg/errors"
)

type ErrCode struct {
	Msg    string
	Status int
	Code   uint32
}

func (err *ErrCode) Error() string {
	return fmt.Sprintf("res err, status = %d, code = %d, msg = %s", err.Status, err.Code, err.Msg)
}

func (err *ErrCode) Wrap() error {
	return errors.Wrap(err, "")
}
