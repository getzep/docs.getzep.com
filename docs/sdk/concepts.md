# Key Concepts


### Collections

A collection is a set of documents that share a common embedding strategy and embedding model. **Zep automatically creates embeddings** from the documents you provide it, or **you can provide the embeddings** when you add your documents to a collection. All documents in a collection must have been embedded using the same model.

### Documents

Documents are the texts that you want to embed and search over. Documents are added to collections. Documents may have a unique ID and metadata associated with them. **If metadata is added, you can use it to filter search results.**

### Embeddings

Embeddings are vectors that represent the semantic meaning of a document. Zep stores both the text and embedding for each document, and uses the embedding to perform semantic search.

Zep can be configured to use, or you can provide, either normalized or unnormalized embeddings.

### Search and Search Scores

Zep supports two types of search: **semantic search** and **hybrid search**. Semantic search uses the document embeddings to find documents that are semantically similar to a query. Hybrid search uses both the document embeddings and metadata to find documents that are semantically similar to a query and match the metadata filters.

You can provide either a text query or an embedding vector when performing a search. If you provide a text query, Zep will embed the query text using the same model that was used to embed the documents in the collection. If you provide an embedding vector, Zep will use that vector directly.

Zep scores search results using **cosine distance** and then **normalizes this distance to a value between 0 and 1**, where 1 is a perfect match. The score is returned as part of the search results.
 