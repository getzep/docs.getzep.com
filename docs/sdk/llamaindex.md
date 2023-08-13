# Building apps with LlamaIndex

Zep has both a `ZepVectorStore` class and a LlamaHub `Reader`.

!!! info "Auto-embed not yet supported"
    
    While Zep can automatically embed your documents, the LlamaIndex implementation of the Zep Vector Store utilizes LlamaIndex’s embedders to do so.

## LlamaHub Reader

The [Zep LlamaHub Reader](https://llamahub.ai/l/zep) returns a set of texts corresponding to a text query or embeddings retrieved from a Zep Collection. The Reader is initialized with a Zep API URL and optionally an API key. The Reader is a simple read-only interface that can then be used to load existing data from a Zep Document Collection.

```python
from llama_index import download_loader

ZepReader = download_loader('ZepReader')

# Create a Zep collection
zep_api_url = "http://localhost:8000" # replace with your Zep API URL
collection_name = "babbage"           # name of an existing Zep collection

query = "Was Babbage awarded a medal?"
reader = ZepReader(api_url=zep_api_url, api_key="optional_api_key")
results = reader.load_data(collection_name=collection_name, query=query, top_k=3)
```

## LlamaIndex VectorStore

The [Zep VectorStore for LlamaIndex](https://gpt-index.readthedocs.io/en/stable/examples/vector_stores/ZepIndexDemo.html) is capable of creating new document Collections,
adding documents to new and existing Collections, and querying Collections for similar documents, via both async and sync APIs. It also supports persisting documents with metadata and filtering search results using metadata.

See the Zep [Vector Store documentation](./documents.md) for details on how to use the LlamaIndex `ZepVectorStore`.

An end-to-end example may be found on the [LlamaIndex documentation page](https://gpt-index.readthedocs.io/en/stable/examples/vector_stores/ZepIndexDemo.html).

## Next Steps
- [Zep SDK documentation](./index.md)
- LlamaIndex [VectorStore documentation](https://gpt-index.readthedocs.io/en/stable/examples/vector_stores/ZepIndexDemo.html)
- [Zep Quick Start Guide](../deployment/quickstart.md) for installation instructions
