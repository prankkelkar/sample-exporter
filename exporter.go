package main

import (
	"fmt"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func main() {
	fmt.Println("starting server")
	// Create a new gauge metric
	helloMetric := prometheus.NewGauge(prometheus.GaugeOpts{
		Name: "hello_metric",
		Help: "Hello World Metric",
	})

	// Register the metric with Prometheus
	prometheus.MustRegister(helloMetric)

	// Set the value of the metric
	helloMetric.Set(1)

	// Create a handler for Prometheus metrics endpoint
	http.Handle("/metrics", promhttp.Handler())

	// Start the HTTP server
	http.ListenAndServe(":8080", nil)
}
