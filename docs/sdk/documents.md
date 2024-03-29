# Document Vector Store API

Zep's document vector store allows you to embed and search over documents using hybrid vector search.

Collection management, document ingestion, and search may be done using either _Zep's SDKs_ or _Langchain_.

[Example Code](examples.md) &nbsp; | &nbsp; [Python API](https://getzep.github.io/zep-python/zep_client/) &nbsp; | &nbsp; [TypeScript API](https://getzep.github.io/zep-js/)

!!! info "`zep-python` supports async use"

    `zep-python` supports async use. All methods are available as both sync and async, with the async methods
    prefixed with `a`. For example, `zep-python` has both `zep_client.memory.add_memory` 
    and `zep_client.memory.aadd_memory` methods.

## Key Concepts

### Collections

A `Collection` is a set of documents that share a common embedding strategy and embedding model. *Zep automatically creates embeddings* from the documents you provide it, or *you can provide the embeddings* when you add your documents to a collection. All documents in a collection must have been embedded using the same model.

### Documents

`Documents` are the texts that you want to embed and search over. Documents are added to collections. Documents may have a unique ID and metadata associated with them. *If metadata is added, you can use it to filter search results.*

### Embedding

Zep supports both _automatic_ and _manual_ embedding. When you add a document to a collection, Zep will automatically embed the document using the embedding model [you've configured for the collection](../deployment/embeddings.md). Alternatively, you can embed your documents yourself and provide the embedding vectors to Zep.

> Want to learn more about embeddings? See *[Selecting Embedding Models](../deployment/embeddings.md)*

### Indexes

Where available, Zep will use a `pgvector v0.5`'s `HNSW` index for vector search over collections. Zep uses cosine distance for the distance function, which supports both normalized and unnormalized vectors.

If you are using a version of `pgvector` prior to `v0.5`, Zep will fall back to using an exact nearest neighbor search over a collection until an `IVFFLAT` index is created. See [Indexing a Collection](#indexing-a-collection) below.

## Initializing the Zep Client

Please see the [SDK documentation](index.md) for more information on initializing the Zep client.

## Creating a Collection

=== ":fontawesome-brands-python: Python"

    ```python
    client = ZepClient(base_url=zep_api_url, api_key="optional_api_key")

    collection_name = "babbagedocs" # the name of your collection. alphanum values only

    collection = client.document.add_collection(
        name=collection_name,  # required
        description="Babbage's Calculating Engine",  # optional
        metadata={"foo": "bar"},  # optional metadata to associate with this collection
        embedding_dimensions=384,  # this must match the model you've configured for
        is_auto_embedded=True,  # use Zep's built-in embedder. Defaults to True
    )
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    const client = await ZepClient.init(zepApiUrl, "optionalApiKey");

    const collection = await client.document.addCollection({
      name: collectionName,
      embeddingDimensions: 384, // must match the dimensions the embedding model
      description: "Babbage's Calculating Engine", // optional
      metadata: { qux: faker.string.sample() }, // optional
      isAutoEmbedded: true, // should Zep automatically embed documents
    });
    ```

=== ":parrot: :chains: LangChain.js"

    If a collection with the given name already exists, it will be returned. Otherwise, a new collection will be created.

    ```typescript
    import { ZepVectorStore } from "langchain/vectorstores/zep";
    import { FakeEmbeddings } from "langchain/embeddings/fake";

    const zepConfig = {
        apiUrl: "http://localhost:8000", // the URL of your Zep implementation
        collectionName,  // the name of your collection. alphanum values only
        embeddingDimensions: 1536,  // much match the embeddings you're using
        isAutoEmbedded: true,  // will automatically embed documents when they are added
    };

    const embeddings = new FakeEmbeddings();  // If you pass in FakeEmbeddings, Zep will use its built-in embedder

    // You can also create a ZepVectorStore using `ZepVectorStore.fromDocuments`
    const vectorStore = await ZepVectorStore(embeddings, zepConfig);
    ```

=== ":llama: LlamaIndex"

    If a collection with the given name already exists, it will be returned. Otherwise, a new collection will be created.

    ```python
    from llama_index.vector_stores import ZepVectorStore

    zep_config = {
        "api_url": "http://localhost:8000",  # the URL of your Zep implementation
        "api_key": "optional_api_key",  # optional API key
        "collection_name": collection_name,  # the name of your collection. alphanum values only
        "embedding_dimensions": 1536,  # much match the embeddings you're using (required if new)
        "is_auto_embedded": True,  # will automatically embed documents when they are added (required if new)
    }

    vector_store = ZepVectorStore(**zep_config)
    ```

`embedding_dimensions` is the width of the vectors outputted by your [embedding model](../deployment/embeddings.md). This must match the model you've configured for Zep to use when embedding texts.
If you'd like to create the embedding vectors yourself and provide these to Zep, this value should match the width of the vectors generated by your model.

`is_auto_embedded` is indicates whether Zep should use its built-in embedder to generate embedding vectors for your documents. If you'd like to create the embedding vectors yourself and provide these to Zep, set this value to `False`.

## Loading an Existing Collection

=== ":fontawesome-brands-python: Python"

    ```python
    collection = client.document.get_collection(collection_name)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    const collection = await client.document.getCollection(collectionName);
    ```

=== ":parrot: :chains: LangChain.js"

    ```typescript
    const zepConfig = {
        apiUrl: "http://localhost:8000", // the URL of your Zep implementation
        collectionName,  // the name of your collection. alphanum values only
    };

    const collection = await ZepVectorStore(embeddings, zepConfig);
    ```

    **Note** See the instructions above regarding passing in `FakeEmbeddings`.

=== ":llama: LlamaIndex"

    ```python
    vector_store = ZepVectorStore(
        api_url=zep_api_url,
        api_key=zep_api_key,
        collection_name=collection_name
    )
    ```

## Adding Documents to a Collection

=== ":fontawesome-brands-python: Python"

    ```python
    chunks = read_chunks_from_file(file, max_chunk_size)  # your custom function to read chunks from a file

    documents = [
        Document(
            content=chunk,
            document_id=f"{collection_name}-{i}",  # optional document ID
            metadata={"bar": i},  # optional metadata
        )
        for i, chunk in enumerate(chunks)
    ]

    uuids = collection.add_documents(documents)
    ```

    `document_id` is an optional ID for your document. You can use this to associate the document chunk of a document with
    your own identifier.

    `metadata` is an optional dictionary of metadata associated with your document. Zep offers hybrid search over a collectiom,
    where metadata can be used to filter search results.

    `collection.add_documents` returns a list of Zep UUIDs for the documents you've added to the collection.

=== ":simple-typescript: TypeScript"

    ```typescript
    const chunks = readChunksFromFile(file, maxChunkSize); // your custom function to read chunks from a file

    const documents = chunks.map((chunk, i) => new Document({
      content: chunk,
      documentId: `${collectionName}-${i}`, // optional document ID mapping to your own identifier
      metadata: { bar: i }, // optional metadata
    }));

    const uuids = await collection.addDocuments(documents);
    ```

    `documentId` is an optional ID for your document. You can use this to associate the document chunk of a document with
    your own identifier.

    `metadata` is an optional dictionary of metadata associated with your document. Zep offers hybrid search over a collectiom,
    where metadata can be used to filter search results.

    `collection.addDocuments` returns a list of Zep UUIDs for the documents you've added to the collection.

=== ":parrot: :chains: Langchain"

    Zep's document vector store has experimental VectorStore support for Langchain.

    While Zep's Memory and Retriever may be found in the Langchain codebase, Zep's VectorStore
    is not yet available in Langchain itself.

    Note the import path below is `zep_python.experimental.langchain`.

    ```python
    from langchain.docstore.base import Document
    from langchain.text_splitter import RecursiveCharacterTextSplitter
    from zep_python.experimental.langchain import ZepVectorStore

    vectorstore = ZepVectorStore(collection)

    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=400,
        chunk_overlap=50,
        length_function=len,
    )

    docs = text_splitter.create_documents([raw_text])
    uuids = vectorstore.add_documents(docs)
    ```

=== ":parrot: :chains: LangChain.js"

    ```typescript
    import { TextLoader } from "langchain/document_loaders/fs/text";

    const loader = new TextLoader("src/document_loaders/example_data/example.txt");
    const docs = await loader.load();

    documentUUIDs = await vectorStore.addDocuments(docs);
    ```

=== ":llama: LlamaIndex"

    ```python
    from llama_index import VectorStoreIndex, SimpleDirectoryReader
    from llama_index.vector_stores import ZepVectorStore
    from llama_index.storage.storage_context import StorageContext

    documents = SimpleDirectoryReader("documents/").load_data()
    storage_context = StorageContext.from_defaults(vector_store=vector_store)
    index = VectorStoreIndex.from_documents(documents, storage_context=storage_context)
    ```

### Chunking your documents

Your _chunking strategy_ will depend on your use case. There are a number of 3rd-party libraries, including Langchain,
that support ingesting documents from a variety of sources and chunking them into smaller pieces for embedding.

You should experiment with different chunking strategies, chunk sizes, overlaps, and embedding models to find the best fit for your problem.

## Monitoring Embedding Progress

Zep's document embedding process is asynchronous. You can monitor the state of your collection by polling the collection's status:

=== ":fontawesome-brands-python: Python"

    ```python
    while True:
        c = client.document.get_collection(collection_name)
        print(
            "Embedding status: "
            f"{c.document_embedded_count}/{c.document_count} documents embedded"
        )
        time.sleep(1)
        if c.status == "ready":
            break
    ```

=== ":simple-typescript: TypeScript"

    ``` typescript
    while (true) {
      const c = await client.document.getCollection(collectionName);
      console.log(
        `Embedding status: ${c.document_embedded_count}/${c.document_count} documents embedded`
      );
      await new Promise((resolve) => setTimeout(resolve, 1000));
      if (c.status === "ready") {
        break;
      }
    }
    ```

When the collection's status is `ready`, all documents have been embedded and are ready for search.

## Searching a Collection using Hybrid Vector Search

Zep supports hybrid vector search over a collection. The most relevant documents are identified and ranked by semantic similarity and, optionally, filtered by matching on metadata associated with your documents.

Either a text query or an embedding vector can be used to search a collection.

!!! info "Constructing Search Queries"

    Zep's Collection and Memory search support semantic search queries, JSONPath-based metadata filters, and a combination of both. Memory search also supports querying by message creation date.

    Read more about [constructing search queries](search_query.md).

=== ":fontawesome-brands-python: Python"

    ```python
    # search for documents using only a query string
    query = "the moon"
    results = collection.search(text=query, limit=5)

    # hybrid search for documents using a query string and metadata filter
    metadata_query = {
        "where": {"jsonpath": '$[*] ? (@.baz == "qux")'},
    }
    results = collection.search(text=query, metadata=metadata_query, limit=5)

    # Search by embedding vector, rather than text query
    # embedding is a list of floats
    results = collection.search(
        embedding=embedding, limit=5
    )
    ```

    `metadata` is an optional dictionary of [JSONPath filters](https://www.ietf.org/archive/id/draft-goessner-dispatch-jsonpath-00.html) used to match on metadata associated with your documents.

    `limit` is an optional integer indicating the maximum number of results to return.

=== ":simple-typescript: TypeScript"

    ```typescript
    // Search for documents using text
    const query = "The celestial motions are nothing but a continual";
    const searchResults = await collection.search({ text: query }, 3);

    // Search for documents using both text and metadata
    const metadataQuery = {
      where: { jsonpath: '$[*] ? (@.bar == "qux")' },
    };

    const newSearchResults = await collection.search(
      {
         text: query,
         metadata: metadataQuery,
      },
      3
    );

    // Search for documents using an embedding vector
    const embeddingSearchResults = await collection.search({ embedding: vectorToSearch }, 3);
    ```

=== ":parrot: :chains: Langchain"

    Zep's Langchain VectorStore may be used as a `Retriever` in a Langchain chain, allowing your chain to search over
    a Zep collection.

    Both `similarity` and `mmr` search types are supported.

    ```python
    query = "What is Charles Babbage best known for?"

    print(f"\nSearching for '{query}'\n")
    results = vectorstore.search(query, search_type="similarity", k=5)
    print_results(results)

    print(f"\nSearching for '{query}' with MMR reranking\n")
    results = vectorstore.search(query, search_type="mmr", k=5)
    print_results(results)

    print(f"\Using Zep's VectorStore as a Retriever\n")
    chain = ConversationalRetrievalChain.from_llm(
        llm=llm,
        chain_type="stuff",
        retriever=vectorstore.as_retriever(),
        memory=memory,
        verbose=True,
    )
    ```

=== ":parrot: :chains: Langchain.js"

    Zep's Langchain VectorStore may be used as a `Retriever` in a Langchain chain, allowing your chain to search over
    a Zep collection.

    Both `similarity` and `mmr` search types are supported.

    ```typescript

    const query = "What is Charles Babbage best known for?";

    // Simple text query returning both documents and scores
    const results = await vectorStore.similaritySearchWithScore(query, 3);

    // MMR reranking
    const mmrResults = await vectorStore.maxMarginalRelevanceSearch(query, {k: 3});

    // Filtering using metadata
    const metadataQuery = {
      where: { jsonpath: '$[*] ? (@.bar == "qux")' },
    };
    const metadataResults = await vectorStore.similaritySearchWithScore(query, 3, metadataQuery);
    ```

=== ":llama: LlamaIndex"

    ```python
    # Search for documents using text
    query = "What is Charles Babbage best known for?"
    query_engine = index.as_query_engine()
    response = query_engine.query(query)

    # Search for documents using both text and a metadata filter
    from llama_index.vector_stores.types import ExactMatchFilter, MetadataFilters

    filters = MetadataFilters(filters=[ExactMatchFilter(key="theme", value="computing")])
    retriever = index.as_retriever(filters=filters)
    result = retriever.retrieve(query)
    ```

## Retrieving Documents by UUID

Zep supports retrieving a list of documents by Zep UUID:

=== ":fontawesome-brands-python: Python"

    ```python
    docs_to_get = uuids[40:50]
    documents = collection.get_documents(docs_to_get)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    const docsToGet = uuids.slice(40, 50);
    const documents = await collection.getDocuments(docsToGet);
    ```

## Indexing a Collection


!!! note "Collections with HNSW Indexes"

    Zep supports approximate nearest neighbor search over collections using `pgvector v0.5`'s `HNSW` index. 
    
    If you are using a version of `pgvector` prior to `v0.5`, Zep will fall back to using an exact nearest neighbor search over a collection until an `IVFFLAT` index is created.

    If you you are using `pgvector v0.5` or later, you do not need to manually create an index. The `index` method is a no-op in this case.

By default, Zep performs exact _nearest neighbor search_ over a collection. Once a collection has a representative set of documents,
you can create an index to improve search performance. After an index is created, Zep will perform an _approximate nearest neighbor search_ over the collection.

By default, the floor on the number of documents required to create an index is 10,000. The `force` argument overrides the floor. This is useful for testing, but is
not recommended for production use as it may result in higher memory usage.

=== ":fontawesome-brands-python: Python"

    ```python
    collection.create_index(force=False)  # Do not use force unless testing!
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    await collection.createIndex(true); // Do not use force unless testing!
    ```

## Other Common Operations

### List all Collections

=== ":fontawesome-brands-python: Python"
    
    ```python
    collections = client.document.list_collections()
    ```

=== ":simple-typescript: TypeScript"
    
    ```typescript
    const collections = await client.document.listCollections();
    ```

### Updating a Collection's Description or Metadata

=== ":fontawesome-brands-python: Python"
    
    ```python
    client.document.update_collection(
        collection_name,
        description="Charles Babbage's Babbage's Calculating Engine 2",
        metadata={"newfoo": "newbar"},
    )
    ```

=== ":simple-typescript: TypeScript"
   
    ```typescript
    await client.document.updateCollection({
        name: collectionName,
        description: "Charles Babbage's Babbage's Calculating Engine 2",
        metadata: { newfoo: "newbar" },
    });
    ```

### Update a Document's ID or Metadata

=== ":fontawesome-brands-python: Python"

    ```python
    collection.update_document(document_uuid, document_id="new_id", metadata={"foo": "bar"})
    ```

=== ":simple-typescript: TypeScript"
   
    ```typescript
    await collection.updateDocument({
        uuid: documentUuid,
        documentId: "new_id",
        metadata: { foo: "bar" },
    });
    ```

### Deleting Documents

Zep supports deleting documents from a collection by UUID:

=== ":fontawesome-brands-python: Python"

    ```python
    collection.delete_document(document_uuid)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    await collection.deleteDocument(documentUuid);
    ```

### Deleting a Collection

Deleting a collection will delete all documents in the collection, as well as the collection itself.

=== ":fontawesome-brands-python: Python"

    ```python
    client.document.delete_collection(collection_name)
    ```

=== ":simple-typescript: TypeScript"
    
    ```typescript
    await client.document.deleteCollection(collectionName);
    ```