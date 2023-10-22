# Constructing Search Queries

## Introduction

Zep's Collection and Memory search supports semantic similarity search and similarity search re-ranked by Maximal Marginal Relevance. 
Both of these search types can be filtered by JSONPath-based metadata filters. Memory search also supports querying by message creation date.

## Simple, Text-based Semantic Queries

The simplest form of search query is a text-based semantic simailrity query. No metadata filter is required, and the query is simply a string of text. Zep will convert the query into an embedding and find semantically similar documents or messages.

Below is an example search against a chat session using only search text.

```typescript
const searchPayload = new MemorySearchPayload({
  metadata: {},
  text: searchText,
});
const searchResults = await zepClient.memory.searchMemory(
  sessionID,
  searchPayload
);
```

Read more about [chat message history search](chat_history/search.md).

## Maximal Marginal Relevance Re-Ranking

Zep supports re-ranking search results using Maximal Marginal Relevance (MMR) over both chat history memory and document collections. 

Maximal Marginal Relevance (MMR) helps balance relevance and diversity in results 
returned during information retrieval, which is useful in vector similarity searches for Retrieval-Augmented Generation (RAG) type applications.

A similarity search may return many highly ranked results that are very similar to each other. Since each subsequent result doesn't add much new information to a prompt, 
adding these may not be very useful. 

MMR helps to reduce redundancy in the results by re-ranking the results to promote diversity, with very similar results 
downranked in favor of different, but still relevant, results.

### How Zep's MMR Re-Ranking Works

When you run a search re-ranked by MMR, Zep retrieves double the number of results, K, you requested. The entire resultset is then reranked using MMR, and the top K results are returned. 

If you request fewer than 10 results, Zep will return 10 results, but still return to you the top K results you requested.

Zep's MMR algorithm is SIMD-hardware accelerated on `amd64` archicture CPUs, ensuring that MMR adds little overhead to your search.



### Constructing an MMR Re-Ranked Search Query



### LangChain and MMR

=== ":parrot: :chains: LangChain.js"
    ```typescript title="Search relevant historical chat messages using MMR"
    import { ZepRetriever } from "langchain/retrievers/zep";

    const mmrRetriever = new ZepRetriever({
      url: process.env.ZEP_URL || "http://localhost:8000",
      sessionId: sessionID,
      topK: 3,
      searchType: "mmr",
      mmrLambda: 0.5,
    });
    const mmrDocs = await mmrRetriever.getRelevantDocuments(query);
    ```
=== ":parrot: :chains: LangChain"
    ```python title="Search relevant historical chat messages using MMR"
    from langchain.retrievers import ZepRetriever
    from langchain.retrievers.zep import SearchType

    zep_retriever = ZepRetriever(
        session_id=session_id,
        url=ZEP_API_URL,
        api_key=zep_api_key,
        top_k=3,
        search_type=SearchType.mmr,
        mmr_lambda=0.5,
    )

    docs = await zep_retriever.aget_relevant_documents("Who wrote Parable of the Sower?")
    ```



## Filtering using Metadata

Zep supports filtering search queries by metadata. Metadata filters are [JSONPath queries](https://www.ietf.org/archive/id/draft-goessner-dispatch-jsonpath-00.html) augmented by a simple boolean logic overlay.

JSONPath queries allow for building sophisticated filters that match on elements at any level of the JSON document. The boolean logic overlay allows for combining multiple JSONPath queries using `and` and `or` operators.

### Useful resources for building and testing JSONPath queries 
- [JSONPath Syntax](https://goessner.net/articles/JsonPath/)
- [JSONPath Online Evaluator](https://jsonpath.com/)
- [JSONPath Expression Tester](https://jsonpath.curiousconcept.com/#).

### Constructing a JSONPath Query Filter

The simplest form of a metadata filter looks as follows:

```json
{
  "where": { "jsonpath": "$[*] ? (@.foo == \"bar\")" }
}
```

If a metadata field `foo` is equal to the string `"bar"`, then the document or message will be returned in the search results.

Executing the above query against a chat session looks as follows:

```typescript
const searchPayload = new MemorySearchPayload({
  text: "Is Lauren Olamina a character in a book",
  metadata: {
    where: { jsonpath: '$[*] ? (@.author == "Octavia Butler")' }
  }
});

const searchResults = await zepClient.memory.searchMemory(sessionID, searchPayload);
```

Or, in the case of querying the MemoryStore using Python:

```python
search_payload = MemorySearchPayload(
    text="Is Lauren Olamina a character in a book",
    metadata={
        "where": {
            "jsonpath": '$[*] ? (@.author == "Octavia Butler")'
        }
    }
)

search_results = client.memory.search_memory(session_id, search_payload)
```

### Combining multiple JSONPath filters using boolean logic

Multiple JSONPath queries can be combined using boolean logic. The following example will return documents or messages where the `author` field is equal to `"Octavia Butler"` **and** the `title` field is equal to `"Parable of the Sower"`.

```json
{
  "where": {
    "and": [
      { "jsonpath": "$[*] ? (@.author == \"Octavia Butler\")" },
      { "jsonpath": "$[*] ? (@.title == \"Parable of the Sower\")" }
    ]
  }
}
```

Similarly, the following example will return documents or messages where the `author` field is equal to `"Octavia Butler"` **or** the `title` field is equal to `"Parable of the Sower"`.

```json
{
  "where": {
    "or": [
      { "jsonpath": "$[*] ? (@.author == \"Octavia Butler\")" },
      { "jsonpath": "$[*] ? (@.title == \"Parable of the Sower\")" }
    ]
  }
}
```

Filter logic can be combined to create arbitrarily complex filters. For example, the following filter will return documents or messages where:

- the `author` field is equal to (`"Octavia Butler"` **and** the `title` field is equal to `"Parable of the Sower"`) 
- **or** the `title` field is equal to `"Parable of the Talents"`.

```json
{
  "where": {
    "or": [
      {
        "and": [
          { "jsonpath": "$[*] ? (@.author == \"Octavia Butler\")" },
          { "jsonpath": "$[*] ? (@.title == \"Parable of the Sower\")" }
        ]
      },
      { "jsonpath": "$[*] ? (@.title == \"Parable of the Talents\")" }
    ]
  }
}
```

## Querying by Message Creation Date

Memory search supports querying by message creation date. The following example will return documents or messages created between June 1, 2023 and June 31, 2023. 

Datetime strings must be in ISO 8601 format.

```json
{
  "start_date": "2023-06-01",
  "end_date": "2023-06-31"
}
```