# Chat History Memory API

[Example Code](examples.md) &nbsp; | &nbsp; [Python API](https://getzep.github.io/zep-python/zep_client/) &nbsp; | &nbsp; [TypeScript/JS API](https://getzep.github.io/zep-js/)


## Overview

Zep's Memory API persists your app's chat history and metadata to a `Session`, enriches the memory, and enables vector similarity search over historical chat messages. 

There are two approaches to populating your prompt with chat history:

- Retrieve the most recent N messages (and potentionally a summary) from a `Session` and use them to construct your prompt.
- Search over the `Session`'s chat history for messages that are relevant and use them to construct your prompt.

Both of these approaches may be useful, with the first providing the LLM with context as to the most recent interactions with a human. The second approach enables you to look back further in the chat history and retrieve messages that are relevant to the current conversation in a token-efficient manner.


## Initializing the Zep Client

Please see the [SDK documentation](index.md) for more information on initializing the Zep client.

!!! info "`zep-python` supports async use"

        `zep-python` supports async use. All methods are available as both sync and async, with the async methods
        prefixed with `a`. For example, `zep-python` has both `zep_client.memory.add_memory` 
        and `zep_client.memory.aadd_memory` methods.

## Next Steps

- Working with [Users](users.md) and [Sessions](sessions.md)
- Persisting and Retrieving [Memories](memories.md)
- Searching over Memories with [Hybrid Search](search.md)


## Zep's Memory Enrichment

You've likely noticed that alongside the role and content you provided to Zep when presisting a memory, Zep also returns a unique identifier, a summary, UUID, a timestamp, token count, extracted entities, and more. The token count is a useful tool to use when constructing prompts, while the extracted entities and other metadata may be useful for building more sophisticated applications.

Zep performs auto-summarization when a session exceeds the message window. This is returned in the `summary` field of the memory when you call `get_memory` and may be used when constructing prompts in order to provide your agent or chain with a longer-term memory of the conversation. Read more about the [Summarizer Extractor](extractors.md/#summarizer-extractor).

Zep also automatically extracts Entities from, and runs an Intent Analysis on, messages in the conversation. The extracted entities and intents are stored in system metadata and available for hybrid searches (see Hybrid Search above).

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
            "intent": "The subject is providing information about a science fiction novel called \"Parable of the Sower\" by Octavia Butler, including a brief summary of its plot and setting.",
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
                },
                {
                "Label": "PERSON",
                "Matches": [
                    {
                    "End": 46,
                    "Start": 32,
                    "Text": "Lauren Olamina"
                    }
                ],
                "Name": "Lauren Olamina"
                },
                {
                "Label": "WORK_OF_ART",
                "Matches": [
                    {
                    "End": 0,
                    "Start": 20,
                    "Text": "Parable of the Sower"
                    }
                ],
                "Name": "Parable of the Sower"
                }
            ]
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
                "intent": "The subject is requesting a brief explanation or summary of Octavia Butler's book, \"Parable of the Sower.\"",
                 "entities": [
                    {
                    "Label": "WORKS_OF_ART",
                    "Matches": [
                        {
                        "End": 46,
                        "Start": 32,
                        "Text": "Parable of the Sower"
                        }
                    ],
                    "Name": "Parable of the Sower"
                    }
                ]
            }
        }
      "token_count": 21
    },
    ...
  ]
}
```


