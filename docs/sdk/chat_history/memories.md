# Memories

A `Memory` is the central data structure in Zep's Memory Store. It contains a list of `Messages` and a `Summary` (if created). The Memory and Summary are returned with UUIDs, [entities extracted from the conversation](../extractors.md), token counts, timestamps, and other metadata.

Memories are associated with a [`Session`](sessions.md) in a many-to-one relationship.

## Persisting a Memory to a Session

A `Memory` may include a single message or a series of messages. Each `Message` has a `role` and `content` field, with role being the identifiers for your human and AI/agent users and content being the text of the message.

Additionally, you can even store custom metadata with each Message.

!!! note "Sessions don't need to be explicitly created"
    Sessions are created automatically when adding Memories. If the `SessionID` is already exists, then the Memory is upserted into the Session.

    **[Manually creating a session](sessions.md) can be useful if you want to associate it with a user or add metadata**

=== ":fontawesome-brands-python: Python"

    ```python title="Add Memory to Session"
    session_id = uuid.uuid4().hex # A new session identifier

    history = [
         { "role": "human", "content": "Who was Octavia Butler?" },
         {
            "role": "ai",
            "content":
               "Octavia Estelle Butler (June 22, 1947 – February 24, 2006) was an American" +
               " science fiction author.",
         },
         {
            "role": "human",
            "content": "Which books of hers were made into movies?",
            "metadata":{"foo": "bar"},
         }
    ]


    messages = [Message(role=m["role"], content=m["content"]) for m in history]
    memory = Memory(messages=messages)
    result = await client.memory.aadd_memory(session_id, memory)
    ```

=== ":simple-typescript: TypeScript"

    ```javascript title="Add Memory to Session"
    const sessionID = randomUUID();

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
            metadata:{"foo": "bar"},
         }
    ];

    const messages = history.map(
         ({ role, content }) => new Message({ role, content })
      );
    const memory = new Memory({ messages });

    await zepClient.memory.addMemory(sessionID, memory);
    ```

## Getting a Session's Memory

=== ":fontawesome-brands-python: Python"

    ```python title="Get Memory from Session"
    async with ZepClient(base_url, api_key) as client:
        try:
            memory = await client.memory.aget_memory(session_id)
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

=== ":simple-typescript: TypeScript"

    ```javascript title="Get Memory from Session"
    const memory = await zepClient.memory.getMemory(sessionID);

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