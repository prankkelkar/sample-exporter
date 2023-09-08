# Use an official Go runtime as a parent image
FROM golang:1.16 as builder

# Set the working directory to /app
WORKDIR /app

# Copy the Go program source code into the container
COPY exporter.go .

# Build the Go program
RUN go build -o exporter .

# Use a lightweight base image for the final container
FROM alpine:latest

# Copy the built binary from the builder stage
COPY --from=builder /app/exporter /app/exporter

# Expose port 8080
EXPOSE 8080

# Run the exporter binary
CMD ["/app/exporter"]
