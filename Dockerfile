FROM golang:latest AS builder
WORKDIR /go/src/app
COPY hello.go ./hello.go
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello

FROM alpine:latest
COPY --from=builder /go/src/app/hello /app/hello
EXPOSE 8080
RUN adduser -D -u 555 unprivuser
USER 555
CMD ["/app/hello"]
