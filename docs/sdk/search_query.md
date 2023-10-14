# Constructing Search Queries

## Introduction

Zep's Collection and Memory search support semantic search queries, JSONPath-based metadata filters, and a combination of both. Memory search also supports querying by message creation date.

## Simple, Text-based Semantic Queries

The simplest form of search query is a text-based semantic query. No metadata filter is required, and the query is simply a string of text. Zep will convert the query into an embedding and find semantically similar documents or messages.

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