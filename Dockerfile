FROM golang:1.19.4-alpine as builder

WORKDIR /go/src/github.com/mpolden/wakeup
RUN apk --no-cache add bash make gcc libc-dev git

COPY . /go/src/github.com/mpolden/wakeup

RUN make install

FROM alpine:3.17

COPY --from=builder /go/src/github.com/mpolden/wakeup/static /opt/wakeup/static
COPY --from=builder /go/bin /opt/wakeup

RUN touch /opt/wakeup/wakeup-cache

ENTRYPOINT [ "/opt/wakeup/wakeupbr" ]
