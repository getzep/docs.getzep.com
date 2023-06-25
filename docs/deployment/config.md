Zep is configured via a yaml configuration file and/or environment variables. The `zep` server accepts a CLI argument `--config` to specify the location of the config file. If no config file is specified, the server will look for a `config.yaml` file in the current working directory.

```bash
zep --config /path/to/config.yaml
```

!!! warning "OpenAI API key and Auth Secret"
    The OpenAI API key and Auth Secret should not be set in the config file, rather the environment variables 
    below should be set. These can also be configured in a `.env` file in the current working directory.

### Docker Compose

The Docker compose setup mounts a `config.yaml` file in the current working directory. Modify the compose file, Dockerfile, and `config.yaml` to your taste.

### Configuration Options

The following table lists the available configuration options.

| Config Key                       | Environment Variable             | Default                                                      |
|----------------------------------|----------------------------------|--------------------------------------------------------------|
| llm.model                        | ZEP_LLM_MODEL                    | gpt-3.5-turbo                                                |
| llm.openai_org_id                | ZEP_LLM_OPENAI_ORG_ID            | undefined                                                    |
| llm.azure_openai_endpoint        | ZEP_LLM_AZURE_OPENAI_ENDPOINT    | undefined                                                    |
| memory.message_window            | ZEP_MEMORY_MESSAGE_WINDOW        | 12                                                           |
| extractors.summarizer.enabled    | ZEP_EXTRACTORS_SUMMARIZER_ENABLE | true                                                         |
| extractors.embeddings.enabled    | ZEP_EMBEDDINGS_ENABLED           | true                                                         |
| extractors.embeddings.dimensions | ZEP_EMBEDDINGS_DIMENSIONS        | 1536                                                         |
| extractors.embeddings.model      | ZEP_EMBEDDINGS_MODEL             | AdaEmbeddingV2                                               |
| memory_store.type                | ZEP_MEMORY_STORE_TYPE            | postgres                                                     |
| memory_store.postgres.dsn        | ZEP_MEMORY_STORE_POSTGRES_DSN    | postgres://postgres:postgres@localhost:5432/?sslmode=disable |
| server.port                      | ZEP_SERVER_PORT                  | 8000                                                         |
| auth.required                    | ZEP_AUTH_REQUIRED                | false                                                        |
| auth.secret                      | ZEP_AUTH_SECRET                  | Requires configuration                                       |
| data.purge_every                 | ZEP_DATA_PURGE_EVERY             | 60 (minutes)                                                 |
| log.level                        | ZEP_LOG_LEVEL                    | info                                                         |
