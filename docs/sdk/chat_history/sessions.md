# Sessions

`Sessions` represent a conversation. Sessions can be associated with [`Users`](../users.md) in a 1:M relationship. 

Chat messages are added to sessions in the form of [`Memories`](memories.md). Each session can have many messages associated with it. 

The `SessionID` is a string key that accepts arbitrary identifiers. Related data you'd like to store can be persisted as metadata.

## Adding a Session

SessionIDs are arbitrary identifiers that you can map to relevant business objects in your app, such as users or a conversation a user might have with your app


!!! note "Sessions don't need to be explicitly created"

    Sessions are created automatically when adding Memories. If the SessionID already exists, then the Memory is upserted into the Session.

    **Manually creating a session can be useful if you want to associate it with a user or add metadata**


=== ":fontawesome-brands-python: Python"

    ```python title="Add a Session"

    async with ZepClient(base_url, api_key) as client:
        session_id = uuid.uuid4().hex # A new session identifier
        session = Session(
                    session_id=session_id, 
                    user_id=user_id,  # Optionally associate this session with a user
                    metadata={"foo" : "bar"}
                )
        await client.memory.aadd_session(session)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript title="Add a Session"
    const sessionData: ISession = {
        session_id: sessionID,
        user_id: userID, // Optionally associate this session with a user
        metadata: { foo: "bar" },
    };
    const session = new Session(sessionData);
    await client.memory.addSession(session);
    ```

## Updating Session Metadata

You can update a session's metadata by providing a Session object with new metadata. Note that
metadata is merged, so any existing metadata will be preserved.

=== ":fontawesome-brands-python: Python"

    ```python title="Update a Session"

    session = Session(session_id=session_id, metadata={"qax" : "baz"})
    await client.memory.aupdate_session(session)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript title="Add a Session"
    const sessionData: ISession = {
        session_id: sessionID,
        metadata: { qax: "baz" },
    };
    const session = new Session(sessionData);
    await client.memory.updateSession(session);
    ```


## Getting a Session

=== ":fontawesome-brands-python: Python"

    ```python title="Get a Session"
    session = await client.memory.aget_session(session_id)
    print(session.dict())

    ```


=== ":simple-typescript: TypeScript"

    ```typescript title="Get a Session"
    const session = await client.memory.getSession(sessionID);
    console.debug("Retrieved session ", session.toDict());
    ```


## Deleting a Session

Deleting a Session soft-deletes the Session and all associated Memories. The Session and Memories are still available in the database, but are marked as deleted and will not be returned in search results.

They will be purged on the next run of the [Zep Purge Process](../../deployment/data.md).

If you persist memory to a deleted Session, it will be undeleted. Deleted Memories will, however, remain deleted.

=== ":fontawesome-brands-python: Python"

    ```python title="Delete a Session and Memory"
    await client.memory.adelete_memory(session_id)
    ```


=== ":simple-typescript: TypeScript"

    ```typescript title="Delete a Session and Memory"

    await client.memory.deleteMemory(sessionID);
    ```

## Listing Sessions

You can list all Sessions in the Zep Memory Store with optional limit and cursor parameters for pagination. We also provider a helper generator function making it simple to iterate over all Sessions.


=== ":fontawesome-brands-python: Python"

    ```python
    # List the first 10 Sessions
    sessions = client.memory.list_sessions(limit=10, cursor=0)
    for session in sessions:
        print(session)

    # List All Sessions using a generator
    all_sessions = client.memory.list_all_sessions(chunk_size=100)
    for session_chunk in all_sessions:
        for session in session_chunk:
            print(session)
    ```

=== ":simple-typescript: TypeScript"

    ```typescript
    // List the first 10 Sessions
    const sessions = await client.memory.listSessions(10, 0);

    // List All Sessions using a generator
    for await (const sessionChunk of client.memory.listSessionsChunked(100)) {
        for (const session of sessionChunk) {
            console.debug("Retrieved session ", session.toDict());
        }
    }
    ```