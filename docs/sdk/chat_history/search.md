# Vector Search over Chat History

Zep allows developers to search the long-term memory store for relevant historical conversations.

## Searching for Messages

Zep supports vector similarity search for Messages in the long-term memory storage. This allows you to find Messages that are contextually similar to a given query, with the results sorted by a similarity or `distance`.

!!! info "Constructing Search Queries"

    Zep's Collection and Memory search support semantic search queries, JSONPath-based metadata filters, and a combination of both. Memory search also supports querying by message creation date.

    Read more about [constructing search queries](../search_query.md).

=== ":fontawesome-brands-python: Python"

    ```python title="Search Memory for Text"
    search_payload = MemorySearchPayload(text="Is Lauren Olamina a character in a book")

    search_results = await client.memory.asearch_memory(session_id, search_payload)

    for search_result in search_results:
        print(search_result.message.dict())
    ```
    ```json title="Output:"
    {
        "message": {
            "uuid": "377ba3dd-d95c-4692-8713-888a2c48d90a",
            "created_at": "2023-05-16T22:35:56.734814Z",
            "role": "ai",
            "content": "Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.",
            "token_count": 56
        },
        "meta": {},
        "summary": null,
        "dist": 0.8006004947773657
    } {
        "message": {
            "uuid": "d30094de-f667-43a7-a5d3-d0114bdbed69",
            "created_at": "2023-05-16T22:35:56.734814Z",
            "role": "human",
            "content": "Who was Octavia Butler?",
            "token_count": 8
        },
        "meta": {},
        "summary": null,
        "dist": 0.7847872122464123
    } {
        "message": {
            "uuid": "7683218a-5a8e-49c6-9451-a0543a7129b2",
            "created_at": "2023-05-16T22:35:56.734814Z",
            "role": "human",
            "content": "Which books of hers were made into movies?",
            "token_count": 11
        },
        "meta": {},
        "summary": null,
        "dist": 0.7816032755893209
    }
    ```

=== ":simple-typescript: TypeScript"

    ```javascript title="Search Memory for Text"
    const searchText = "Is Lauren Olamina a character in a book?";

    const searchPayload = new MemorySearchPayload({ metadata: {}, text: searchText });
    const searchResults = await zepClient.memory.searchMemory(
        sessionID,
        searchPayload
    );

    searchResults.forEach((searchResult) => {
        console.debug(JSON.stringify(searchResult));
    });
    ```
    ```json title="Output:"
    {
        "message": {
            "uuid": "377ba3dd-d95c-4692-8713-888a2c48d90a",
            "created_at": "2023-05-16T22:35:56.734814Z",
            "role": "ai",
            "content": "Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.",
            "token_count": 56
        },
        "meta": {},
        "summary": null,
        "dist": 0.8006004947773657
    } {
        "message": {
            "uuid": "d30094de-f667-43a7-a5d3-d0114bdbed69",
            "created_at": "2023-05-16T22:35:56.734814Z",
            "role": "human",
            "content": "Who was Octavia Butler?",
            "token_count": 8
        },
        "meta": {},
        "summary": null,
        "dist": 0.7847872122464123
    } {
        "message": {
            "uuid": "7683218a-5a8e-49c6-9451-a0543a7129b2",
            "created_at": "2023-05-16T22:35:56.734814Z",
            "role": "human",
            "content": "Which books of hers were made into movies?",
            "token_count": 11
        },
        "meta": {},
        "summary": null,
        "dist": 0.7816032755893209
    }
    ```

## Hybrid Search for Messages using Message Metadata

In addition to vector similarity search for Messages in the long-term memory storage, Zep also allows you to search for Messages based on a metadata filter. This allows you to find Messages that match a combination of Message text and metadata filter. You can also query solely by specifying Message metadata.

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
Where available, Zep will use a `pgvector v0.5`'s HNSW index for vector search over messages. Zep uses cosine distance for the distance function.

If you are using a version of `pgvector` prior to `v0.5`, Zep will fall back to using an exact nearest neighbor search. 

It is possible to manually create an `IVFFLAT` index on the `message_embedding` table's `embedding` column to improve search performance.

```sql
CREATE INDEX ON message_embedding USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);
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