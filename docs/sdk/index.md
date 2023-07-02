# Developing with Zep

## Installation

Zep offers both [Python](https://github.com/getzep/zep-python) and [Javascript](https://github.com/getzep/zep-js) SDKs.

Python SDK documentation can be [found here](https://getzep.github.io/zep-python/zep_client/).


=== "Python"

    ``` bash
    pip install zep-python

    # or

    poetry add zep-python
    ```

=== "Javascript"

    ``` bash
    npm install @getzep/zep-js

    # or

    yarn add @getzep/zep-js
    ```

!!! note "Running the Zep Server"

    The Zep SDKs require a running Zep server. See the [Quickstart Guide](deployment/quickstart) for more information.

## Initializing the Client

!!! note "Zep supports optional JWT authentication."
    
        The examples below assume that you have enabled JWT authentication.
        See the [Authentication Configuration Guide](/deployment/auth) for more information.

=== "Python"

    ```python
    from zep_python import ZepClient

    # Replace with Zep API URL and (optionally) API key
    zep = ZepClient("http://localhost:8000", api_key="optional_key") 
    ```

=== "Javascript"

    ```javascript
    import { ZepClient } from "zep-js";

    // Replace with Zep API URL and (optionally) API key
    const zep = new ZepClient("http://localhost:8000", apiKey="optional_key"); 
    ```

## Key Concepts

### Sessions

**Sessions** represent your users. The Session ID is a string key that accepts arbitrary identifiers. Metadata can be set alongside the Session ID. Explicit creation of Sessions is unnecessary, as they are created automatically when adding Memories.

Related to sessions, a time series of **Memories** and **Summaries** is captured and stored.

### Memory

A **Memory** is the core data structure in Zep. It contains a list of **Messages** and a **Summary** (if created). The Memory and Summary are returned with UUIDs, token counts, timestamps, and other metadata, allowing for a rich set of application-level functionality.

## Persisting a Memory to a Session

A `Memory` may include a single message or a series of messages. Each `Message` has a `role` and `content` field, with role being the identifiers for your human and AI/agent users and content being the text of the message.

Additionally, you can even store custom metadata with each Message. 

Sessions are created automatically when adding Memories. The SessionID is a string key that accepts arbitrary identifiers.

=== "Python"

    ```python title="Add Memory to Session"
    from zep_python import Memory, Message, ZepClient

    base_url = "http://localhost:8000"  # TODO: Replace with Zep API URL
    session_id = "2a2a2a" # an identifier for your user

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

    async with ZepClient(base_url) as client:
        messages = [Message(role=m.role, content=m.content) for m in history]
        memory = Memory(messages=messages)
        result = await client.aadd_memory(session_id, memory)
    ```

=== "Javascript"

    ```javascript title="Add Memory to Session"
    import { ZepClient, Message, Memory } from "zep-js";

    const zep = new ZepClient("http://localhost:8000"); // Replace with Zep API URL
    const sessionID = "1a1a1a"; // an identifier for your user

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

    await client.addMemory(sessionID, memory);
    ```

## Getting a Session's Memory

=== "Python"

    ```python title="Get Memory from Session"
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

=== "Javascript"

    ```javascript title="Get Memory from Session"
    const memory = await client.getMemory(sessionID);

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
    search_payload = SearchPayload(text="Is Lauren Olamina a character in a book")

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

=== "Javascript"

    ```javascript title="Search Memory for Text"
    const searchText = "Is Lauren Olamina a character in a book?";

    const searchPayload = new SearchPayload({ meta: {}, text: searchText });
    const searchResults = await client.searchMemory(
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
In addition to vector similarity search for Messages in the long-term memory storage, Zep also allows you to search for Messages based on a metadata filter. This allows you to find Messages that match a combination of Message text and  metadata filter. You can also query solely by specifying Message metadata. 

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

=== "Javascript"

    ```javascript title="Hybrid Search Memory for Text, Metadata"
    const searchText = "I enjoy reading science fiction.";

    const searchPayload = new MemorySearchPayload({
        metadata: {
            "where": {"jsonpath": '$[*] ? (@.foo == "bar")'},
        },
        text: searchText,
    });

    const searchResults = await client.searchMemory(sessionID, searchPayload);

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

Zep performs auto-summarization when a session exceeds the message window. This is returned in the `summary` field of the memory when you call `get_memory` and may be used when constructing prompts in order to provide your agent or chain with a longer-term memory of the conversation. Read more about the [Summarizer Extractor](/extractors/#summarizer-extractor).

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
