# Configuring Zep

Zep is configured via a yaml configuration file and/or environment variables.
The `zep` server accepts a CLI argument `--config` to specify the location of the config file.
If no config file is specified, the server will look for a `config.yaml` file in the current working directory.

```bash
zep --config /path/to/config.yaml
```

!!! warning "OpenAI / Anthropic API key and Auth Secret"

    Your OpenAI/Anthropic API key and Auth Secret should not be set in the config file, rather the environment variables
    below should be set. These can also be configured in a `.env` file in the current working directory.

## Zep Server

The Zep server can be configured via environment variables, a `.env` file, or the `config.yaml` file. The following table lists the available configuration options.

Note the defaults below for the embedding models and review the [Selecting Embedding Models](#selecting-embedding-models) section below for more information.


### Server Config

| Config Key                                  | Environment Variable                            | Default                                                      |
|---------------------------------------------|-------------------------------------------------|--------------------------------------------------------------|
| store.type                                  | ZEP_STORE_TYPE                                  | postgres                                                     |
| store.postgres.dsn                          | ZEP_STORE_POSTGRES_DSN                          | Installation dependent.                                      |
| server.host                                 | ZEP_SERVER_HOST                                 | 0.0.0.0                                                      |
| server.port                                 | ZEP_SERVER_PORT                                 | 8000                                                         |
| server.web_enabled                          | ZEP_SERVER_WEB_ENABLED                          | true                                                         |
| server.max_request_size                     | ZEP_SERVER_MAX_REQUEST_SIZE                     | 5242880                                                      |
| nlp.server_url                              | ZEP_NLP_SERVER_URL                              | Installation dependent.                                      |
| development                                 | ZEP_DEVELOPMENT                                 | false                                                        |
| log.level                                   | ZEP_LOG_LEVEL                                   | info                                                         |

### Authentication Config

Please see the [Authentication](auth.md) documentation for more information on configuring authentication.

| Config Key                                  | Environment Variable                            | Default                                                      |
|---------------------------------------------|-------------------------------------------------|--------------------------------------------------------------|
| auth.required                               | ZEP_AUTH_REQUIRED                               | false                                                        |
| auth.secret                                 | ZEP_AUTH_SECRET                                 | do-not-use-this-secret-in-production                         |
| data.purge_every                            | ZEP_DATA_PURGE_EVERY                            | 60                                                           |

### LLMs

See the [LLM Configuration](llm_config.md) for more information on configuring LLMs.

!!! info "Anthropic does not support embeddings"

    If configuring Zep to use the Anthropic LLM service, you must configure Zep to use the local embeddings service.

| Config Key                                  | Environment Variable                            | Default                                                      |
|---------------------------------------------|-------------------------------------------------|--------------------------------------------------------------|
| llm.service                                 | ZEP_LLM_SERVICE                                 | openai                                                       |
| llm.model                                   | ZEP_LLM_MODEL                                   | gpt-3.5-turbo                                                |
| llm.azure_openai_endpoint                   | ZEP_LLM_AZURE_OPENAI_ENDPOINT                   | undefined                                                    |
| llm.openai_endpoint                         | ZEP_LLM_OPENAI_ENDPOINT                         | undefined                                                    |
| llm.openai_org_id                           | ZEP_LLM_OPENAI_ORG_ID                           | undefined                                                    |
| llm.azure_openai                            | ZEP_LLM_AZURE_OPENAI                            | undefined                                                    |
| llm.azure_openai_endpoint                   | ZEP_LLM_AZURE_OPENAI_ENDPOINT                   | undefined                                                    |

### Enrichment and Extraction

See the [Enrichment and Extraction](../sdk/extractors.md) documentation for more information on configuring enrichment and extraction.

| Config Key                                  | Environment Variable                            | Default                                                      |
|---------------------------------------------|-------------------------------------------------|--------------------------------------------------------------|
| memory.message_window                       | ZEP_MEMORY_MESSAGE_WINDOW                       | 12                                                           |
| extractors.documents.embeddings.enabled     | ZEP_EXTRACTORS_DOCUMENTS_EMBEDDINGS_ENABLED     | true                                                         |
| extractors.documents.embeddings.dimensions  | ZEP_EXTRACTORS_DOCUMENTS_EMBEDDINGS_DIMENSIONS  | 384                                                          |
| extractors.documents.embeddings.service     | ZEP_EXTRACTORS_DOCUMENTS_EMBEDDINGS_SERVICE     | local                                                        |
| extractors.documents.embeddings.chunk_size  | ZEP_EXTRACTORS_DOCUMENTS_EMBEDDINGS_CHUNK_SIZE  | 1000                                                         |
| extractors.messages.summarizer.enabled      | ZEP_EXTRACTORS_MESSAGES_SUMMARIZER_ENABLED      | true                                                         |
| extractors.messages.entities.enabled        | ZEP_EXTRACTORS_MESSAGES_ENTITIES_ENABLED        | true                                                         |
| extractors.messages.intent.enabled          | ZEP_EXTRACTORS_MESSAGES_INTENT_ENABLED          | false                                                        |
| extractors.messages.embeddings.enabled      | ZEP_EXTRACTORS_MESSAGES_EMBEDDINGS_ENABLED      | true                                                         |
| extractors.messages.embeddings.dimensions   | ZEP_EXTRACTORS_MESSAGES_EMBEDDINGS_DIMENSIONS   | 384                                                          |
| extractors.messages.embeddings.service      | ZEP_EXTRACTORS_MESSAGES_EMBEDDINGS_SERVICE      | local                                                        |
| extractors.messages.summarizer.embeddings.enabled   | ZEP_EXTRACTORS_MESSAGES_SUMMARIZER_EMBEDDINGS_ENABLED   | true                                         |
| extractors.messages.summarizer.embeddings.dimensions| ZEP_EXTRACTORS_MESSAGES_SUMMARIZER_EMBEDDINGS_DIMENSIONS| 384                                          |
| extractors.messages.summarizer.embeddings.service   | ZEP_EXTRACTORS_MESSAGES_SUMMARIZER_EMBEDDINGS_SERVICE   | local                                        |
| custom_prompts.summarizer_prompts.openai    | ZEP_CUSTOM_PROMPTS_SUMMARIZER_PROMPTS_OPENAI    | See Zep's source code for details                            |
| custom_prompts.summarizer_prompts.anthropic | ZEP_CUSTOM_PROMPTS_SUMMARIZER_PROMPTS_ANTHROPIC | See Zep's source code for details                            |

### Data Management

See the [Data Management](data.md) documentation for more information on configuring data management.

| Config Key                                  | Environment Variable                            | Default                                                      |
|---------------------------------------------|-------------------------------------------------|--------------------------------------------------------------|
| data.purge_every                            | ZEP_DATA_PURGE_EVERY                            | 60                                                           |

### Valid LLM Models

The following table lists the valid LLM models for the `llm.model` configuration option.

| Provider  | Model             |
| --------- | ----------------- |
| OpenAI    | gpt-3.5-turbo     |
| OpenAI    | gpt-3.5-turbo-16k |
| OpenAI    | gpt-4             |
| OpenAI    | gpt-4-32k         |
| Anthropic | claude-instant-1  |
| Anthropic | claude-2          |

## Zep NLP Server

The Zep NLP Server may be configured via a `.env` file or environment variables.
The following table lists the available configuration options.
Note that the NLP server's container is not shipped with CUDA nor configured to use GPU acceleration.

Note the defaults below for the embedding models and review the [Selecting Embedding Models](#selecting-embedding-models) section below for more information.

| Config Key                   | Environment Variable             | Default          |
| ---------------------------- | -------------------------------- | ---------------- |
| log_level                    | ZEP_LOG_LEVEL                    | info             |
| server.port                  | ZEP_SERVER_PORT                  | 5557             |
| embeddings.device            | ZEP_EMBEDDINGS_DEVICE            | cpu              |
| embeddings.messages.enabled  | ZEP_EMBEDDINGS_MESSAGES_ENABLED  | true             |
| embeddings.messages.model    | ZEP_EMBEDDINGS_MESSAGES_MODEL    | all-MiniLM-L6-v2 |
| embeddings.documents.enabled | ZEP_EMBEDDINGS_DOCUMENTS_ENABLED | true             |
| embeddings.documents.model   | ZEP_EMBEDDINGS_DOCUMENTS_MODEL   | all-MiniLM-L6-v2 |
| nlp.spacy_model              | ZEP_NLP_SPACY_MODEL              | en_core_web_sm   |
