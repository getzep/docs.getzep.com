# Developing with Zep

## Installation

Zep offers both [Python](https://github.com/getzep/zep-python) and [Javascript](https://github.com/getzep/zep-js) SDKs.

=== "Python"

    ``` bash
    pip install zep-python

    # or

    poetry add zep-python
    ```

=== "Javascript"

    ``` bash
    npm install zep-js

    # or

    yarn add zep-js
    ```

!!! note "Running the Zep Server"

    The Zep SDKs require a running Zep server. See the [Quickstart Guide](deployment/quickstart) for more information.

## Initializing the Client

=== "Python"

    ```python
    from zep_python import ZepClient

    zep = ZepClient("http://localhost:8000") # Replace with Zep API URL
    ```

=== "Javascript"

    ```javascript
    import { ZepClient } from "zep-js";

    const zep = new ZepClient("http://localhost:8000"); // Replace with Zep API URL
    ```

## Key Concepts

### Sessions

**Sessions** represent your users. The Session ID is a string key that accepts arbitrary identifiers. Metadata can be set alongside the Session ID. Explicit creation of Sessions is unnecessary, as they are created automatically when adding Memories.

Related to sessions, a time series of **Memories** and **Summaries** is captured and stored.

### Memory

A **Memory** is the core data structure in Zep. It contains a list of **Messages** and a **Summary** (if created). The Memory and Summary are returned with UUIDs, token counts, timestamps, and other metadata, allowing for a rich set of application-level functionality.

## Persisting a Memory to a Session

A `Memory` may include a single message or a series of messages. Each `Message` has a `role` and `content` field, with role being the identifiers for your human and AI/agent users and content being the text of the message.

Sessions are created automatically when adding Memories. The SessionID is a string key that accepts arbitrary identifiers.

=== "Python"

    ```python
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
         }
    ]

    async with ZepClient(base_url) as client:
        messages = [Message(role=m.role, content=m.content) for m in history]
        memory = Memory(messages=messages)
        result = await client.aadd_memory(session_id, memory)
    ```

=== "Javascript"

    ```javascript
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
         }
    ];

    const messages = history.map(
         ({ role, content }) => new Message({ role, content })
      );
    const memory = new Memory({ messages });

    await client.addMemoryAsync(sessionID, memory);
    ```

## Getting a Session's Memory

=== "Python"

    ```python
    try:
        memories = await client.aget_memory(session_id)
        for memory in memories:
            for message in memory.messages:
                print(message.to_dict())
    except NotFoundError:
        print("Memory not found")
    ```
    ```text
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

    ```javascript
    const newMemories = await client.getMemoryAsync(sessionID);

    if (newMemories.length === 0) {
        console.debug("No memory found for session ", sessionID);
    } else {
        newMemories.forEach((memory) => {
            memory.messages.forEach((message) => {
                console.debug(message.toDict());
            });
        });
    }
    ```
    ```text
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

    ```python
    search_payload = SearchPayload(text="Is Lauren Olamina a character in a book")

    search_results = await client.asearch_memory(session_id, search_payload)

    for search_result in search_results:
        print(search_result.message.to_dict())
    ```
    ```text
    {"message":{"uuid":"377ba3dd-d95c-4692-8713-888a2c48d90a","created_at":"2023-05-16T22:35:56.734814Z","role":"ai","content":"Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.","token_count":56},"meta":{},"summary":null,"dist":0.8006004947773657}
    {"message":{"uuid":"d30094de-f667-43a7-a5d3-d0114bdbed69","created_at":"2023-05-16T22:35:56.734814Z","role":"human","content":"Who was Octavia Butler?","token_count":8},"meta":{},"summary":null,"dist":0.7847872122464123}
    {"message":{"uuid":"7683218a-5a8e-49c6-9451-a0543a7129b2","created_at":"2023-05-16T22:35:56.734814Z","role":"human","content":"Which books of hers were made into movies?","token_count":11},"meta":{},"summary":null,"dist":0.7816032755893209}
    ```

=== "Javascript"

    ```javascript
    const searchText = "Is Lauren Olamina a character in a book?";

    const searchPayload = new SearchPayload({ meta: {}, text: searchText });
    const searchResults = await client.searchMemoryAsync(
        sessionID,
        searchPayload
    );

    searchResults.forEach((searchResult) => {
        console.debug(JSON.stringify(searchResult));
    });
    ```
    ```text
    {"message":{"uuid":"377ba3dd-d95c-4692-8713-888a2c48d90a","created_at":"2023-05-16T22:35:56.734814Z","role":"ai","content":"Parable of the Sower is a science fiction novel by Octavia Butler, published in 1993. It follows the story of Lauren Olamina, a young woman living in a dystopian future where society has collapsed due to environmental disasters, poverty, and violence.","token_count":56},"meta":{},"summary":null,"dist":0.8006004947773657}
    {"message":{"uuid":"d30094de-f667-43a7-a5d3-d0114bdbed69","created_at":"2023-05-16T22:35:56.734814Z","role":"human","content":"Who was Octavia Butler?","token_count":8},"meta":{},"summary":null,"dist":0.7847872122464123}
    {"message":{"uuid":"7683218a-5a8e-49c6-9451-a0543a7129b2","created_at":"2023-05-16T22:35:56.734814Z","role":"human","content":"Which books of hers were made into movies?","token_count":11},"meta":{},"summary":null,"dist":0.7816032755893209}
    ```

## Exploring Auto-Summarization, Token Counts, and Zep Enrichment
