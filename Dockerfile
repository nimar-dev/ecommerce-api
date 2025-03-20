# Stage 1: Build the Go application
FROM golang:1.23.4 AS builder

WORKDIR /app

# Copy everything and build the app
COPY . .
RUN go mod tidy
RUN go build -o ecommerce-api cmd/main.go

# Stage 2: Create a minimal image with the built binary
FROM alpine:latest

WORKDIR /root/

# Copy the built binary from the builder stage
COPY --from=builder /app/ecommerce-api .

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["./ecommerce-api"]