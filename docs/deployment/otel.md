# OpenTelemetry Tracing

Zep supports [OpenTelemetry](https://opentelemetry.io/) tracing. This allows you to trace requests through the Zep service, identify bottlenecks, and understand the performance of your Zep deployment. In particular, this is useful to understand how LLM service latency might be impacting your Zep operations.

## Enabling OpenTelemetry

Set `opentelemetry.enabled` to true in your `config.yaml` file or set the `ZEP_OPENTELEMETRY_ENABLED` environment variable to true. 

Then, set your OpenTelemetry Exporter config in your environment. This is vendor specific, but you can an example below.

```
OTEL_SERVICE_NAME="zep"
OTEL_EXPORTER_OTLP_ENDPOINT="<your endpoint>"
OTEL_EXPORTER_OTLP_TRACES_ENDPOINT="<your endpoint>"
OTEL_EXPORTER_OTLP_HEADERS="YOUR-AUTH-HEADER"
```