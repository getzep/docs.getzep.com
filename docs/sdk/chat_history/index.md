# Chat History Memory API

[Key Concepts](concepts.md) &nbsp; | &nbsp; [Example Code](examples.md) &nbsp; | &nbsp; [Python API](https://getzep.github.io/zep-python/zep_client/) &nbsp; | &nbsp; [TypeScript/JS API](https://getzep.github.io/zep-js/)

!!! info "Python SDK offers both async and sync APIs"

    The examples below use the async API. A sync API is also available.

## Adding a Session

Session IDs are arbitrary identifiers that you can map to relevant business objects in your app, such as users or a conversation a user might have with your app.

You can therefore map them either 1:1 with your users or in a 1:M relationship with your users.

Sessions don't need to be explicitly created. They are created automatically when adding Memories. If the SessionID already exists, then the Memory is upserted into the Session.

Manually creating a session can be useful if you want to add metadata to a session.

=== "Python"

    ```python title="Add a Session"

    async with ZepClient(base_url, api_key) as client:
    session_id = uuid.uuid4().hex // A new session identifier

    session = Session(session_id=session_id, metadata={"foo" : "bar"})
    client.aadd_session(session)
    ```

=== "TypeScript"

    ```typescript title="Add a Session"
    const sessionData: ISession = {
        session_id: sessionID,
        metadata: { foo: "bar" },
    };
    const session = new Session(sessionData);
    await client.memory.addSession(session);
    ```

### Adding or Updating Session Metadata

If the Session already exists, then adding a Session works as an upsert operation for the Session metadata.

## Getting a Session

=== "Python"

    ```python title="Get a Session"
    session = client.aget_session(session_id)
    print(session.dict())

    ```
    ```json title="Output:"
    {
        "uuid": "944045d3-82ea-41c3-9228-13df83960eba",
        "created_at": "2023-07-12T16:49:53.00569Z",
        "updated_at": "2023-07-12T16:49:53.00569Z",
        "deleted_at": "0001-01-01T00:00:00Z",
        "session_id": "487012daa30b45ab94c5d086fa8942ec",
        "metadata": {
            "bar": "foo",
            "foo": "bar"
        }
    }
    ```

=== "TypeScript"

    ```typescript title="Get a Session"
    const session = await client.memory.getSession(sessionID);
    console.debug("Retrieved session ", session.toDict());
    ```
    ```json title="Output:"
    {
        "uuid": "944045d3-82ea-41c3-9228-13df83960eba",
        "created_at": "2023-07-12T16:49:53.00569Z",
        "updated_at": "2023-07-12T16:49:53.00569Z",
        "deleted_at": "0001-01-01T00:00:00Z",
        "session_id": "487012daa30b45ab94c5d086fa8942ec",
        "metadata": {
            "bar": "foo",
            "foo": "bar"
        }
    }
    ```

## Persisting a Memory to a Session

A `Memory` may include a single message or a series of messages. Each `Message` has a `role` and `content` field, with role being the identifiers for your human and AI/agent users and content being the text of the message.

Additionally, you can even store custom metadata with each Message.

Sessions are created automatically when adding Memories. If the SessionID is already exists, then the Memory is upserted into the Session.

=== "Python"

    ```python title="Add Memory to Session"
    session_id = "2a2a2a"

    history = [
         { role: "human", content: "Who was Octavia Butler?" },
         {
            role: "ai",
            content:
               "Octavia Estelle Butler (June 22, 1947 – February 24, 2006) was an American" +
               " science fiction author.",
         },
         {
            role: "human",
            content: "Which books of hers were made into movies?",
            metadata={"foo": "bar"},
         }
    ]


    messages = [Message(role=m.role, content=m.content) for m in history]
    memory = Memory(messages=messages)
    result = await client.aadd_memory(session_id, memory)
    ```

=== "TypeScript"

    ```javascript title="Add Memory to Session"
    const sessionID = "1a1a1a";

    const history = [
         { role: "human", content: "Who was Octavia Butler?" },
         {
            role: "ai",
            content:
               "Octavia Estelle Butler (June 22, 1947 – February 24, 2006) was an American" +
               " science fiction author.",
         },
         {
            role: "human",
            content: "Which books of hers were made into movies?",
            metadata={"foo": "bar"},
         }
    ];

    const messages = history.map(
         ({ role, content }) => new Message({ role, content })
      );
    const memory = new Memory({ messages });

    await zepClient.addMemory(sessionID, memory);
    ```

## Getting a Session's Memory

=== "Python"

    ```python title="Get Memory from Session"
    async with ZepClient(base_url, api_key) as client:
        try:
            memory = await client.aget_memory(session_id)
            for message in memory.messages:
                print(message.to_dict())
        except NotFoundError:
            print("Memory not found")
    ```
    ```json title="Output:"
    {
        "uuid": "7291333f-2e01-4b06-9fe0-3efc59b3399c",
        "created_at": "2023-05-16T21:59:11.057919Z",
        "role": "ai",
        "content": "Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.",
        "token_count": 56
    }
    {
        "uuid": "61f862c5-945b-49b1-b87c-f9338518b7cb",
        "created_at": "2023-05-16T21:59:11.057919Z",
        "role": "human",
        "content": "Write a short synopsis of Butler's book, Parable of the Sower. What is it about?",
        "token_count": 23
    }
    ```

=== "TypeScript"

    ```javascript title="Get Memory from Session"
    const memory = await zepClient.getMemory(sessionID);

    if (memory.messages.length === 0) {
        console.debug("No messages found for session ", sessionID);
    } else {
        memory.messages.forEach((message) => {
            console.debug(JSON.stringify(message));
        });
    }
    ```
    ```json title="Output:"
    {
        uuid: '7291333f-2e01-4b06-9fe0-3efc59b3399c',
        created_at: '2023-05-16T21:59:11.057919Z',
        role: 'ai',
        content: 'Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.',
        token_count: 56
    }
    {
        uuid: '61f862c5-945b-49b1-b87c-f9338518b7cb',
        created_at: '2023-05-16T21:59:11.057919Z',
        role: 'human',
        content: "Write a short synopsis of Butler's book, Parable of the Sower. What is it about?",
        token_count: 23
    }
    ```

## Searching for Messages

Zep supports vector similarity search for Messages in the long-term memory storage. This allows you to find Messages that are contextually similar to a given query, with the results sorted by a similarity or `distance`. See [Vector Search](/memory_search) for more details.

=== "Python"

    ```python title="Search Memory for Text"
    search_payload = MemorySearchPayload(text="Is Lauren Olamina a character in a book")

    search_results = await client.asearch_memory(session_id, search_payload)

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

=== "TypeScript"

    ```javascript title="Search Memory for Text"
    const searchText = "Is Lauren Olamina a character in a book?";

    const searchPayload = new MemorySearchPayload({ meta: {}, text: searchText });
    const searchResults = await zepClient.searchMemory(
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

=== "Python"

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

=== "TypeScript"

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

## Exploring Auto-Summarization, Token Counts, and Zep Enrichment

You've likely noticed that alongside the role and content you provided to Zep when presisting a memory, Zep also returns a unique identifier, a UUID, a timestamp, and a token count. The token count is a useful tool to use when constructing prompts, while the other metadata may be useful for other applications.

Zep performs auto-summarization when a session exceeds the message window. This is returned in the `summary` field of the memory when you call `get_memory` and may be used when constructing prompts in order to provide your agent or chain with a longer-term memory of the conversation. Read more about the [Summarizer Extractor](extractors.md/#summarizer-extractor).

Zep also automatically extracts Intents from the conversation. The extracted intents are stored in system metadata and available for hybrid searches (see Hybrid Search above).

```json title="Output:"
{
  "summary": {
    "uuid": "afe3957b-032f-47e0-8317-ed2953a2fb49",
    "created_at": "2023-05-16T22:59:22.979937Z",
    "content": "The AI provides a summary of Octavia Butler's Parable of the Sower, detailing the story of Lauren Olamina in a dystopian future. When the human asks for recommendations for other women sci-fi writers, the AI suggests Ursula K. Le Guin and Joanna Russ. The human follows up by asking about Butler's awards, and the AI lists the Hugo Award, Nebula Award, and MacArthur Fellowship. They also discuss Butler's contemporaries, the FX adaptation of Kindred, and Butler's background as an American science fiction author.",
    "recent_message_uuid": "8834423d-9388-4a6a-bee2-091754407241",
    "token_count": 644
  },
  "messages": [
    {
      "uuid": "96c2597e-7c13-48ee-bb5e-1f4f4663b2d2",
      "created_at": "2023-05-16T22:59:33.612956Z",
      "role": "ai",
      "content": "Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.",
      "system": {
            "intent": "The subject is providing information about a science fiction novel called \"Parable of the Sower\" by Octavia Butler, including a brief summary of its plot and setting."
        }
      "token_count": 253
    },
    {
      "uuid": "b235e682-75b3-44b2-b083-4572cdbc86b1",
      "created_at": "2023-05-16T22:59:33.612956Z",
      "role": "human",
      "content": "Write a short synopsis of Butler's book, Parable of the Sower. What is it about?",
      "metadata": {
          "system": {
                "intent": "The subject is requesting a brief explanation or summary of Octavia Butler's book, \"Parable of the Sower.\""
            }
        }
      "token_count": 21
    },
    {
      "uuid": "fa209c5e-3937-4d33-b659-1aa4fb0d1967",
      "created_at": "2023-05-16T22:59:33.612956Z",
      "role": "ai",
      "content": "You might want to read Ursula K. Le Guin or Joanna Russ.",
      "metadata": {
          "system": {
              "intent": "The subject is suggesting books or authors to read."
            }
        },
"token_count": 18
    },
    {
      "uuid": "d783da86-405f-45c6-862a-16901fbae33e",
      "created_at": "2023-05-16T22:59:33.612956Z",
      "role": "human",
      "content": "Which other women sci-fi writers might I want to read?",
      "metadata": {
          "system": {
              "intent": "The subject is asking for recommendations on women science-fiction writers besides the one they have already read."
            }
        },
      "token_count": 17
    },
    {
      "uuid": "5a5433c6-ce1b-48be-9aa4-5782d742d11d",
      "created_at": "2023-05-16T22:59:33.612956Z",
      "role": "ai",
      "content": "Octavia Butler won the Hugo Award, the Nebula Award, and the MacArthur Fellowship.",
      "metadata": {
          "system": {
              "intent": "The subject is making a statement about the achievements and recognition received by Octavia Butler."
            }
        },
      "token_count": 26
    },
    {
      "uuid": "89e951f2-8156-4a47-b86d-129e9804211d",
      "created_at": "2023-05-16T22:59:33.612956Z",
      "role": "human",
      "content": "What awards did she win?",
      "metadata": {
        "system": {
            "intent": "The subject is inquiring about the awards won by a specific person."
            }
        },
      "token_count": 8
    }
  ],
  "metadata": {}
}
```

## Vector Search over Chat History

Zep allows developers to search the long-term memory store for relevant historical conversations.

### Search Ranking and Limits

Zep returns all messages from a search, up to a default limit. This limit which can overridden by passing a `limit` querystring argument to the search API. Given the sparsity issue discussed below, we suggest only using the top 2-3 messages in your prompts. Alternatively, analyze your search results and use a distance threshold to filter out irrelevant messages.

!!! note "Embedding short texts"

    Contextual search over chat histories is challenging: chat messages are typically short and can lack "information". When combined with high-dimensional embedding vectors, short texts can create very sparse vectors.

    This vector sparsity results in many vectors appearing close to each other in the vectorspace. This may in turn result in many false positives when searching for relevant messages.

    We're thinking of strategies to address this problem, including hybrid search and enriching messages with metadata.

### Default Embedding Models

#### Docker Container Deployments

By default, Zep uses OpenAI's 1536-wide AdaV2 embeddings and cosine similarity for search ranking.

#### All other deployments

By default, Zep uses a built-in Sentence Transformers model, `all-MiniLM-L6-v2`, for message embedding. The model offers a very low latency
search experience when deployed on suitable infrastructure. Cosine similarity is used for search ranking.

Other embedding models and services, such as OpenAI, may be configured. See the [Zep NLP Service](../deployment/config.md) configuration.
