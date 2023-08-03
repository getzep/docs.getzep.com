# Zep v0.9.0-beta Deployment Guide

The following instructions will guide you through deploying Zep v0.9.0-beta. For instructions on deploying Zep v0.8.1 Stable, please refer to the [Zep Quick Start Guide](/deployment/quickstart).


!!! important "Upgrading from Stable? Read this."

    **Configuration options have changes signficiantly between Zep v0.8.1 Stable and Zep v0.9.0-beta.** Please carefuly review the guide below before upgrading. _And make a database backup!_

## Prerequisites

The following guide assumes familiarity with Docker, some basic networking experience, and a level of comfort at the command line. 

## Hardware Requirements

For production deployment planning, please be mindful of the following.

### Memory requirements

You will need adequate memory for Zep's NLP and Postgres containers. The amount of memory required will be dictated by:
  
- **NLP Server**: The number of different embedding models you will be using and the size of these models. See [Selecting Embedding Models](#selecting-embedding-models) below.
- **Postgres** As the number of documents in your Collections grow and you create indexes over these collections, you will need to ensure that you have adequate memory available. Please see Postgres best practice deployment guides for more information.

### Database storage requirements

Zep's Postgres database will require adequate storage for your documents, document vectors, chat message histories, and chat message history vectors. The amount of storage required will be dictated by your use case, the width of your embedding vectors, and other variables.

## Deploying Zep
### Docker Compose

```bash
git clone https://github.com/getzep/zep.git
cd zep
docker compose -f docker-compose-beta.yaml up
```

This will start a Zep server on port `8000`, an NLP server on port `5557`, and a Postgres database on port `5432`.

### Kubernetes and Render

Zep v0.9.0-beta does not yet have Kubernetes or Render deployment options. You can however use the docker compose file above for a guide on deploying to these platforms.

!!! Warning "Configure Server Authentication"

    If you are deploying Zep to a production environemnt or where Zep APIs are exposed to the public internet, 
    please ensure that you secure your Zep server by [configuring authentication](/deployment/auth).
    Failing to do so will leave your server open to the public.


## Install the Zep Python SDK

Ensure that you install the right version of the SDK for the server you are running.

If you're running 1.9.0-beta, install the beta Python SDK:

```bash
pip install --pre zep-python
```

Best practice would be to pin to s specific version of the SDK:

```bash
pip install zep-python==1.0b0
```

## Install the Zep JavaScript SDK

We're still working on this. Thanks for your patience!


## Configuring Zep
### Zep Server

The Zep server can be configured via environment variables, a `.env` file, or the `config-beta.yaml` file. The following table lists the available configuration options. 

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

The Zep NLP Server may be configured via a `.env` file or environment variables. The following table lists the available configuration options. Note that the NLP server's container is not shipped with CUDA nor configured to use GPU acceleration.

Note the defaults below for the embedding models and review the [Selecting Embedding Models](#selecting-embedding-models) section below for more information.

| Config Key                 | Environment Variable       | Default          |
|----------------------------|----------------------------|------------------|
| log_level                  | LOG_LEVEL                  | info             |
| server.port                | SERVER_PORT                | 5557             |
| embeddings.device          | EMBEDDINGS_DEVICE          | cpu              |
| embeddings.messages.model  | EMBEDDINGS_MESSAGES_MODEL  | all-MiniLM-L6-v2 |
| embeddings.documents.model | EMBEDDINGS_DOCUMENTS_MODEL | all-MiniLM-L6-v2 |
| nlp.spacy_model            | NLP_SPACY_MODEL            | en_core_web_sm   |


Note that the NLP server's port has changed to `5557` in v0.9.0-beta.



## Selecting Embedding Models

Zep embeds chat messages you persist to the Chat Memory Store. If you've configured your document Collection to auto-embed (the default), then Zep will also embed documents you persist to the Document Vector Store. You may also embed documents yourself and pass these documents and embedding vectors to Zep.

Document and the Chat Memory Store's Message embedding options can be set separately.

There are two options for embedding models: 

- **OpenAI's API** (default _prior_ to v0.9.0-beta). This may be configured in the [Zep server's config file or via environment variables](#zep-server). Set `embeddings.service` or the equivalent environment variable to `openai` and the `embeddings.dimensions` to `1536`.
- **Local** (_default in v0.9.0-beta_). This may be configured in the [Zep server's config file or via environment variables](#zep-server). Set `embeddings.service` or the equivalent environment variable to `local` and the `embeddings.dimensions` to the vector width of your chosen model.

For the local option, you may choose from the following models:

- **Default configured:** [`all-MiniLM-L6-v2`](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2) a small, memory efficient, very fast, and surprisingly accurate model.
- **Other Sentence Transformer compatible models** of your choice. These can be normalized or not. Be mindful of the model's memory requirements and inference speed. See the [Sentence Transformer documentation](https://www.sbert.net/docs/pretrained_models.html) for more information.

**Important:** Update the `embeddings.dimensions` Zep server config settings to match the vector width of your chosen model.


!!! note "Docker on  Macs: Embedding is slow!"

    Zep relies on PyTorch for embedding inference. On MacOS, Zep's NLP server runs in a Linux ARM64 container. PyTorch is not optimized to run on Linux ARM64 and does not have access to MacBook M-series acceleration hardware.
    **For MacOS development purposes, we recommend using OpenAI's embedding service.**

## When and how to Create a Collection Index

Please see the [Collection Indexing](/sdk/documents/#indexing-a-collection) section of the Zep SDK documentation for more information.

### Next Steps

- Setting up [authentication](/deployment/auth)
- Developing with [Zep SDKs](/sdk)
- Learn about [Extractors](/extractors)