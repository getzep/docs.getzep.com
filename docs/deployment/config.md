
Zep is configured via a yaml configuration file and/or environment variables. 
The `zep` server accepts a CLI argument `--config` to specify the location of the config file. 
If no config file is specified, the server will look for a `config.yaml` file in the current working directory.

```bash
zep --config /path/to/config.yaml
```

!!! warning "OpenAI API key and Auth Secret"
  
    The OpenAI API key and Auth Secret should not be set in the config file, rather the environment variables
    below should be set. These can also be configured in a `.env` file in the current working directory.

## Configuring Zep
### Zep Server

The Zep server can be configured via environment variables, a `.env` file, or the `config.yaml` file. The following table lists the available configuration options.

Note the defaults below for the embedding models and review the [Selecting Embedding Models](#selecting-embedding-models) section below for more information.

!!! warning "OpenAI API key and Auth Secret"
  
    The OpenAI API key and Auth Secret should not be set in the config file, rather the environment variables
    below should be set. These can also be configured in a `.env` file in the current working directory.


| Config Key                                 | Environment Variable                           | Default                                                      |
|--------------------------------------------|------------------------------------------------|--------------------------------------------------------------|
| llm.model                                  | ZEP_LLM_MODEL                                  | gpt-3.5-turbo                                                |
| llm.azure_openai_endpoint                  | ZEP_LLM_AZURE_OPENAI_ENDPOINT                  | undefined                                                    |
| llm.openai_endpoint                        | ZEP_LLM_OPENAI_ENDPOINT                        | undefined                                                    |
| llm.openai_org_id                          | ZEP_LLM_OPENAI_ORG_ID                          | undefined                                                    |
| memory.message_window                      | ZEP_MEMORY_MESSAGE_WINDOW                      | 12                                                           |
| extractors.documents.embeddings.enabled    | ZEP_EXTRACTORS_DOCUMENTS_EMBEDDINGS_ENABLED    | true                                                         |
| extractors.documents.embeddings.dimensions | ZEP_EXTRACTORS_DOCUMENTS_EMBEDDINGS_DIMENSIONS | 384                                                          |
| extractors.documents.embeddings.service    | ZEP_EXTRACTORS_DOCUMENTS_EMBEDDINGS_SERVICE    | local                                                        |
| extractors.messages.summarizer.enabled     | ZEP_EXTRACTORS_MESSAGES_SUMMARIZER_ENABLED     | true                                                         |
| extractors.messages.entities.enabled       | ZEP_EXTRACTORS_MESSAGES_ENTITIES_ENABLED       | true                                                         |
| extractors.messages.intent.enabled         | ZEP_EXTRACTORS_MESSAGES_INTENT_ENABLED         | false                                                        |
| extractors.messages.embeddings.enabled     | ZEP_EXTRACTORS_MESSAGES_EMBEDDINGS_ENABLED     | true                                                         |
| extractors.messages.embeddings.dimensions  | ZEP_EXTRACTORS_MESSAGES_EMBEDDINGS_DIMENSIONS  | 384                                                          |
| extractors.messages.embeddings.service     | ZEP_EXTRACTORS_MESSAGES_EMBEDDINGS_SERVICE     | local                                                        |
| store.type                                 | ZEP_STORE_TYPE                                 | postgres                                                     |
| store.postgres.dsn                         | ZEP_STORE_POSTGRES_DSN                         | postgres://postgres:postgres@localhost:5432/?sslmode=disable |
| server.port                                | ZEP_SERVER_PORT                                | 8000                                                         |
| auth.required                              | ZEP_AUTH_REQUIRED                              | false                                                        |
| auth.secret                                | ZEP_AUTH_SECRET                                | do-not-use-this-secret-in-production                         |
| data.purge_every                           | ZEP_DATA_PURGE_EVERY                           | 60                                                           |
| log.level                                  | ZEP_LOG_LEVEL                                  | info                                                         |



### Zep NLP Server

The Zep NLP Server may be configured via a `.env` file or environment variables. 
The following table lists the available configuration options. 
Note that the NLP server's container is not shipped with CUDA nor configured to use GPU acceleration.

Note the defaults below for the embedding models and review the [Selecting Embedding Models](#selecting-embedding-models) section below for more information.

| Config Key                 | Environment Variable       | Default          |
|----------------------------|----------------------------|------------------|
| log_level                  | LOG_LEVEL                  | info             |
| server.port                | SERVER_PORT                | 5557             |
| embeddings.device          | EMBEDDINGS_DEVICE          | cpu              |
| embeddings.messages.model  | EMBEDDINGS_MESSAGES_MODEL  | all-MiniLM-L6-v2 |
| embeddings.documents.model | EMBEDDINGS_DOCUMENTS_MODEL | all-MiniLM-L6-v2 |
| nlp.spacy_model            | NLP_SPACY_MODEL            | en_core_web_sm   |