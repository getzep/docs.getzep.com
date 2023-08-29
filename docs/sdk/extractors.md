# Message Extractors

Zep Extractors extract information from messages. Currently, Zep has three extractors, with more planned:

- A progressive summarizer
- An embedding vectorizer
- A Named Entity Recognizer (NER)
- A token counter
- An intent extractor

!!! note

    Extractors run asycronously. This ensures that the chat experience is not impacted by the time it takes to extract information from messages. Howeever, this does mean that the extracted information may not be immediately available after message persistence.

## Summarizer Extractor

The Summarizer Extractor summarizes an unsummarized message history once it exceeds the Message Window. Once the history exceeds this window, the summarizer will summarize any old memories over half the message window size. This is intended to limit significant LLM usage.

!!! Example

    If the message window is set to 12, and the number of unsummarized memories exceeds 12, the summarizer will summarize any memories older than 6 messages. Retrieving the Zep message history at this stage will, by default, return the most recent 6 messages and the summary.

The summarizer prioritizes context from newer messages and as a result offers the LLM model more information regarding recent coversations. To offer the LLM relevant context from older conversation, utilize Zep's vector similarity search.

Zep stores a history of summaries and the point at which they were made. This provides flexibility for future summarization strategies you may want to implement.

### Configuring the Message Window

The Message Window is defined in the [Zep config file](../deployment/config.md).

## Embedder Extractor

The Embedder Extractor [embeds new messages](../deployment/embeddings.md) as they are persisted to the memory store. This makes them available for semantic vector search. By default, we use OpenAI's 1536-wide AdaV2 embeddings.

## Named Entity Recognizer (NER)

The Entity Extractor extracts named entities from messages and stores them in the message metadata. Zep uses state-of-the-art NLP toolkit, [spaCy](https://spacy.io/), with entity extraction running locally, with no need for LLM access. With the Entity Extractor, developers can:

- Trigger the use of custom prompts or agent branching;
- Annotate the chat history, enhancing the experience for users with links to additional information, services, or products.
- Evaluate human and agent messages further to extract dates, currencies, people's names, place names, etc.
- and much more.

Below is an example out of the Entity Extractor. The message metadata field is populated asynchronously, and may be accessed via the Zep `GetMemory` and Search APIs. The `Matches` field contains the start and end character positions of the entity in the message.

```json
 {"metadata": {
    "system": {
      "entities": [
        {
          "Label": "WORK_OF_ART",
          "Matches": [
            {
              "End": 144,
              "Start": 119,
              "Text": "The Left Hand of Darkness"
            }
          ],
          "Name": "The Left Hand of Darkness"
        },
        {
          "Label": "PERSON",
          "Matches": [
            {
              "End": 165,
              "Start": 148,
              "Text": "Ursula K. Le Guin"
            }
          ],
          "Name": "Ursula K. Le Guin"
        },
        {
          "Label": "PERSON",
          "Matches": [
            {
              "End": 235,
              "Start": 224,
              "Text": "Joanna Russ"
            }
          ],
          "Name": "Joanna Russ"
        },
...
```

We're currently using spaCy's smallest English language model, `en_core_web_sm`, for entity extraction. This provides a good balance between accuracy and inference time, with the latter being important for low-latency chat applications. 

The [spaCy source code](https://github.com/explosion/spaCy/blob/9b7a59c325c85f49f8e978c9d9b8b29b42e577cb/spacy/glossary.py#L328) has list of entity labels and their descriptions.

## Token Count Extractor

The Token Count Extractor counts the number of tokens in a message, and stores the count in the message metadata. This allows for finer-grained control over prompt assembly.

## Intent Extractor

The Intent Extractor passes the conversational messages to an LLM and extracts the Intents which are then stored as system metadata along with the Messages. For example,

```json
    {
        "uuid": "c26b5afd-1290-4feb-a4ce-306d4612ee7a",
        "created_at": "2023-06-21T19:33:04.720778Z",
        "role": "human",
        "content": "I'm looking for a new skincare product.",
        "metadata": {
            "CustomerFirstName": "Alice",
            "CustomerID": "KDSJFJDSF",
            "LoyaltyTier": "Loyal",
            "system": {
                "intent": "The subject is in search of a new skincare product."
            }
        },
        "token_count": 11
    },
```

## Extending Zep with new Extractors

Zep's Extractor model is easily extensible, with a simple, clean interface available to build new enrichment functionality, such as summarizers, entity extractors, embedders, and more.

New Extractors can be added by implementing the `Extractor` interface:

```go
type Extractor interface {
	Extract(
		ctx context.Context,
		appState *AppState,
		messageEvents *MessageEvent,
	) error
	Notify(ctx context.Context, appState *AppState, messageEvents *MessageEvent) error
}
```

Zep uses an observor pattern to notify extractors of new messages. Extractors register with the Zep `MemoryStore` to receive notifications when new messages are persisted to the store.

The `MemoryStore` calls the `Notify` method on each registered extractor, passing the new messages in a `MessageEvent`. The `Notify` method then calls the `Extract` method, which performs the actual extraction asyncronously in a go routine.

See the Zep repo for more details on building [Extractors](https://github.com/getzep/zep/tree/main/pkg/extractors).
