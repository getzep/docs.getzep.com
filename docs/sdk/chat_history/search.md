# Vector Search over Chat History

Zep allows developers to search the Zep long-term memory store for relevant historical conversations.

## Searching for Messages or Summaries

Zep supports vector similarity search for Messages or Summaries of messages stored by Zep. This allows you to populate prompts with past conversations contextually similar to a given query, with the results sorted by a similarity score or `distance`.

### When to use Summaries versus Messages

Zep supports searching for both Messages and Summaries. Given that individual messages may lack conversational context, Summaries are often a better choice for search. See the discussion about [message limitations](http://localhost:8001/sdk/chat_history/search/#limitations) below.

Messages, however, can contain specific details that may be useful for your application. It is possible to execute both types of searches within your app.

### MMR Reranking Summaries
Since summaries often share information, particualrly when the Message Window is set to a lower threshold, it is often useful to use [Maximum Marginal Relevance (MMR)](../search_query.md) reranking of search results. Zep has build-in, hardware accelerated support for MMR and enabling it is simple.

!!! info "Constructing Search Queries"

    Zep's Collection and Memory search support semantic search queries, JSONPath-based metadata filters, and a combination of both. Memory search also supports querying by message creation date.

    Read more about [constructing search queries](../search_query.md).

=== ":fontawesome-brands-python: Python"

    ```python title="Search Summaries"
    from zep_python import (
        MemorySearchPayload,
        ZepClient,
    )

    # This uniquely identifies the user's session
    session_id = "my_session_id"

    # Initialize the Zep client before running this code
    search_payload = MemorySearchPayload(
        text="Is Lauren Olamina a character in a book?",
        search_scope="summary", # This could be messages or summary
        search_type="mmr", # remove this if you'd prefer not to rerank results
        mmr_lambda=0.5, # tune diversity vs relevance
    )

    search_results = await client.memory.asearch_memory(session_id, search_payload)

    for search_result in search_results:
        # Uncomment for message search
        # print(search_result.messsage.dict())
        print(search_result.summary.dict())
    ```
    ```json title="Abridged Output:"
    {
        "summary": {
            "uuid": "b47b83da-16ae-49c8-bacb-f7d049f9df99",
            "created_at": "2023-11-02T18:22:10.103867Z",
            "content": "The human asks the AI to explain the book Parable of the Sower by Octavia Butler. The AI responds by explaining that Parable of the Sower is a science fiction novel by Octavia Butler. The book follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.",
            "token_count": 66
        },
        "metadata": null,
        "dist": 0.8440576791763306
    }
    ```

=== ":simple-typescript: TypeScript"

    ```typescript title="Search Messages"
    import {
        MemorySearchPayload,
        ZepClient,
    } from '@getzep/zep-js';

    // This uniquely identifies the user's session
    const sessionID = "my_session_id";
    const searchText = "Is Lauren Olamina a character in a book?";

    // Initialize the ZepClient before running this code

    // Create a new MemorySearchPayload with the search text, scope, type, and MMR lambda
    const searchPayload = new MemorySearchPayload({
        text: searchText,
        search_scope: "summary", // This could be messages or summary
        search_type: "mmr", // remove this if you'd prefer not to rerank results
        mmr_lambda: 0.5, // tune diversity vs relevance
    });

    // Perform the memory search with the session ID, search payload, and a limit of 3 results
    const searchResults = await client.memory.searchMemory(sessionID, searchPayload, 3);

    searchResults.forEach((searchResult) => {
        console.debug(JSON.stringify(searchResult));
    });
    ```
    ```json title="Abridged Output:"
    {
        "summary": {
            "uuid": "b47b83da-16ae-49c8-bacb-f7d049f9df99",
            "created_at": "2023-11-02T18:22:10.103867Z",
            "content": "The human asks the AI to explain the book Parable of the Sower by Octavia Butler. The AI responds by explaining that Parable of the Sower is a science fiction novel by Octavia Butler. The book follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.",
            "token_count": 66
        },
        "metadata": null,
        "dist": 0.8440576791763306
    }
    ```

## Hybrid Search for Chat History using Metadata Filters

In addition to vector similarity search for Messages and Summaries in stored in Zep, Zep also allows you to search using metadata filters. This allows you to find Messages or Summaries that match a combination of text and metadata filter. You can also query solely by specifying metadata.

=== ":fontawesome-brands-python: Python"

    ```python title="Hybrid Search Memory for Text, Metadata"
    zep_client.search_memory(
        session_id=session_id,
        search_payload=MemorySearchPayload(
            query="I enjoy reading science fiction.",
            metadata={
                "where": {"jsonpath": '$[*] ? (@.foo == "bar")'},
            },
        ),
    )
    ```
    ```json title="Output:"
    {
        "dist": 0.7170433826192629,
        "message": {
            "content": "I've read many books written by Octavia Butler.",
            "created_at": "2023-06-03T22:00:43.034056Z",
            "metadata": {
                "foo": "bar",
                "system": {
                "entities": [
                    {
                    "Label": "PERSON",
                    "Matches": [
                        {
                        "End": 46,
                        "Start": 32,
                        "Text": "Octavia Butler"
                        }
                    ],
                    "Name": "Octavia Butler"
                    }
                ]
            }
        },
        "role": "human",
        "token_count": 13,
        "uuid": "8f3a06dd-0625-41da-a2af-b549f2056b3f"
        },
        "metadata": null,
        "summary": null
    }
    ```

=== ":simple-typescript: TypeScript"

    ```javascript title="Hybrid Search Memory for Text, Metadata"
    const searchText = "I enjoy reading science fiction.";

    const searchPayload = new MemorySearchPayload({
        metadata: {
            "where": {"jsonpath": '$[*] ? (@.foo == "bar")'},
        },
        text: searchText,
    });

    const searchResults = await zepClient.searchMemory(sessionID, searchPayload);

    ```
    ```json title="Output:"
    {
        "dist": 0.7170433826192629,
        "message": {
            "content": "I've read many books written by Octavia Butler.",
            "created_at": "2023-06-03T22:00:43.034056Z",
            "metadata": {
                "foo": "bar",
                "system": {
                "entities": [
                    {
                    "Label": "PERSON",
                    "Matches": [
                        {
                        "End": 46,
                        "Start": 32,
                        "Text": "Octavia Butler"
                        }
                    ],
                    "Name": "Octavia Butler"
                    }
                ]
            }
        },
        "role": "human",
        "token_count": 13,
        "uuid": "8f3a06dd-0625-41da-a2af-b549f2056b3f"
        },
        "metadata": null,
        "summary": null
    }
    ```


### Search Ranking and Limits

#### Vector Indexes
Where available, Zep will use a `pgvector v0.5`'s HNSW index for vector search over messages and summaries. Zep uses cosine distance for the distance function.

If you are using a version of `pgvector` prior to `v0.5`, Zep will fall back to using an exact nearest neighbor search. 

If you don't have access to `pgvector v0.5`, is possible to manually create `IVFFLAT` indexes to improve search performance.

```sql
CREATE INDEX ON message_embedding USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);
CREATE INDEX ON summary_embedding USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);
```

Please see the [pgevector documentation](https://github.com/pgvector/pgvector#ivfflat) for information on selecting the size of the `lists` parameter.

#### Limitations

Zep returns all messages from a search, up to a default limit. This limit which can overridden by passing a `limit` querystring argument to the search API. Given the sparsity issue discussed below, we suggest only using the top 2-3 messages in your prompts. Alternatively, analyze your search results and use a distance threshold to filter out irrelevant messages.

!!! note "Embedding short texts"

    Contextual search over chat histories is challenging: chat messages are typically short and can lack "information". When combined with high-dimensional embedding vectors, short texts can create very sparse vectors.

    This vector sparsity results in many vectors appearing close to each other in the vectorspace. This may in turn result in many false positives when searching for relevant messages.


### Embedding Models


#### Docker Container Deployments

By default, Zep uses OpenAI's 1536-wide AdaV2 embeddings for docker deployments.

#### All other deployments

By default, Zep uses a built-in Sentence Transformers model, `all-MiniLM-L6-v2`, for message embedding. The `all-MiniLM-L6-v2` model offers a very low latency search experience when deployed on suitable infrastructure.


!!! note "`all-MiniLM-L6-v2` Model Limitations"

    The `all-MiniLM-L6-v2` model has a 256 word piece limit. If your messages are likely to be larger, it is recommended you select an alternative model. 

#### Selecting alternative models

Other embedding models and services, such as OpenAI, may be configured. See the [Zep NLP Service](../../deployment/config.md) configuration.