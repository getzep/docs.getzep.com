# Zep by Example

The Zep SDK repos have several examples of using Zep's Document Vector Store and Memory Store, both directly with Zep's SDKs and via LangChain.

## Zep Python

- [End-to-end Document Vector Store example](https://github.com/getzep/zep-python/blob/main/examples/documents.py): Chunking a document, building a Collection, search, creating an index, and more.
- [Simple LangChain VectorStore example](https://github.com/getzep/zep-python/blob/main/examples/langchain_simple_demo.py): Chunking a document, building a Collection, and search.
- Using the [Zep VectorStore with a LangChain `ConversationalRetrievalChain`](https://github.com/getzep/zep-python/blob/main/examples/langchain_qa_chain.py): As the title implies.
- Using [LangChain's `OpenAIEmbeddings` to embed a document](https://github.com/getzep/zep-python/blob/main/examples/langchain_openai_embeddings.py) and pass the resulting vectors to the Zep VectorStore.

## Zep JS

- [End-to-end Document Vector Store example](https://github.com/getzep/zep-js/blob/main/examples/documents/index.ts): Chunking a document, building a Collection, search, creating an index, and more.