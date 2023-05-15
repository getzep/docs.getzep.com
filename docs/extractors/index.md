# Message Extractors

Zep Extractors extract information from messages. Currently, Zep has three extractors, with more planned:

- A progressive summarizer
- An embedding vectorizer
- A token counter

## Summarizer Extractor

The Summarizer Extractor summarizes an unsummarized message history once it exceeds the Message Window. Once the history exceeds this window, the summarizer will summarize any old memories over half the message window size. This is intended to limit significant LLM usage.

!!! Example

    If the message window is set to 12, and the number of unsummarized memories exceeds 12, the summarizer will summarize any memories older than 6 messages. Retrieving the Zep message history at this stage will, by default, return the most recent 6 messages and the summary.

The summarizer prioritizes context from newer messages and as a result offers the LLM model more information regarding recent coversations. To offer the LLM relevant context from older conversation, utilize Zep's [contextual vector search](/memory_search).

Zep stores a history of summaries and the point at which they were made. This provides flexibility for future summarization strategies you may want to implement.

### Configuring the Message Window

The Message Window is defined in the [Zep config file](/deployment/config).

## Embedder Extractor

The Embedder Extractor embeds new messages as they are persisted to the memory store. This makes them available for [semantic vector search](/memory_search). By default, we use OpenAI's 1536-wide AdaV2 embeddings.

## Token Count Extractor

The Token Count Extractor counts the number of tokens in a message, and stores the count in the message metadata. This allows for finer-grained control over prompt assembly.

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
