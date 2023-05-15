# Concepts 
## Sessions
Sessions represent your users. The Session ID is a string key that accepts arbitrary identifiers. Metadata can be set alongside the Session ID. Explicit creation of Sessions is unnecessary, as they are created automatically when adding Memories.

Related to sessions, a time series of Memories and Summaries is captured and stored.

## Memory
A Memory is the core data structure in Zep. It contains a list of Messages and a Summary (if created). The Memory and Summary are returned with UUIDs, token counts, timestamps, and other metadata, allowing for a rich set of application-level functionality.

## Message Window
The Message Window, as set in the config file, defines when the Summarizer will summarize Memory contents. Once the number of unsummarized memories exceeds the message window, the summarizer will summarize any old memories over half the message window size. This is intended to limit significant LLM usage.

!!! note "Regarding Memory Gets"
    When retrieving Memories, the most recent Messages up to the last Message summarized are returned, alongside the Summary. The UUID of the newest message in the Summary is also returned as a pointer to the conversational history. The message limit can be overriden by passing the `lastN` querystring argument in the `GET` call.

## Extractors

Zep's `Extractor` framework allows for the simple addition of functionality that extracts information from messages. 

Currently, Zep has three extractors: 

- A progressive summarizer
- An embedding vectorizer
- A token counter
- More to come.

## Next Steps

- [Quick Start](quickstart): Run a Zep server locally and a primer on the Python or Javascript SDKs.