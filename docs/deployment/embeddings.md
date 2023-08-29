# Selecting Embedding Models

!!! info "Always match the vector width of your chosen model"

    Update the `embeddings.dimensions` Zep server config settings to match the vector width of your chosen model.

Zep embeds chat messages you persist to the Chat Memory Store. If you've configured your document Collection to auto-embed (the default), then Zep will also embed documents you persist to the Document Vector Store. You may also embed documents yourself and pass these documents and embedding vectors to Zep.

Document and the Chat Memory Store's Message embedding options can be set separately.

## Embedding Options

There are two options for embedding models:

- **OpenAI's API** (default with docker compose deploys). This may be configured in the [Zep server's config file, `docker-compose.yaml` or via environment variables](./config.md). Set `embeddings.service` or the equivalent environment variable to `openai` and the `embeddings.dimensions` to `1536`.
- **Local** This may be configured in the [Zep server's config file or via environment variables](./config.md). Set `embeddings.service` or the equivalent environment variable to `local` and the `embeddings.dimensions` to the vector width of your chosen model.

## Local Embedding Models

For the local option, you may choose from the following models:

- **Default configured:** [`all-MiniLM-L6-v2`](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2) a small, memory efficient, very fast, and surprisingly accurate model.
- **Other Sentence Transformer compatible models** of your choice. These can be normalized or not. Be mindful of the model's memory requirements and inference speed. See the [Sentence Transformer documentation](https://www.sbert.net/docs/pretrained_models.html) for more information.

## Embedding Model Considerations

- **Maximum Sequence Length** Models have maximum input sequence lengths. If you exceed this length, the model will truncate your input. This may result in poor embeddings. Select a model that matches your chunking stratgy. Note that `all-MiniLM-L6-v2` has a maximum sequence length of 256 characters.
- **Speed** Zep, as shipped, uses CPU inference. The larger the model, the slower the inference.
- **Memory** The larger the model, the more memory it will require.

!!! note "Docker on Macs: Local Embedding is slow!"

    **For docker compose deployment we default to using OpenAI's embedding service.**

    Zep relies on PyTorch for embedding inference. On MacOS, Zep's NLP server runs in a Linux ARM64 container. PyTorch is not optimized to run on Linux ARM64 and does not have access to MacBook M-series acceleration hardware.
