# Messages

`Messages` represent individual messages in a conversation. Messages are associated with [`Sessions`](sessions.md) in a M:1 relationship.

Messages must be added to sessions using [`Memories`](memories.md).

## Get a Specific Message from a Session

To retrieve a specific message from a session, you can use the `get_session_message` method. Here are examples in Python and TypeScript:

=== ":fontawesome-brands-python: Python"

    ```python title="Get Message from Session"
    async with ZepClient(base_url, api_key) as client:
        try:
            session_id = "3e0e4af9-71ff-4541-b206-6133574bbbc6"  # Replace with the actual session_id
            message_id = "3e0e4af9-71ff-4541-b206-6133574bbbc7"  # Replace with the actual message_id
            message = await client.message.aget_session_message(session_id, message_id)
            print(message.to_dict())
        except NotFoundError:
            print("Message not found")
    ```
    ```json title="Output"
    {
      "uuid": "3e0e4af9-71ff-4541-b206-6133574bbbc7",
      "created_at": "2023-12-08T22:17:33.185756Z",
      "updated_at": "0001-01-01T00:00:00Z",
      "role": "human",
      "content": "Who were her contemporaries?",
      "metadata": {
        "system": {
          "entities": [],
          "intent": "The subject is requesting information about the people who were living at the same time as the woman in question."
        }
      }
    }
    ```

=== ":simple-typescript: TypeScript"

    ```javascript title="Get message from Session"
    const sessionID = "3e0e4af9-71ff-4541-b206-6133574bbbc6";  // Replace with the actual session ID
    const messageID = "3e0e4af9-71ff-4541-b206-6133574bbbc7";  // Replace with the actual message ID

    try {
        const message = await zepClient.message.getSessionMessage(sessionID, messageID);
        console.debug(JSON.stringify(message));
    } catch (error) {
        console.debug("Message not found");
    }
    ```
    ```json title="Output"
    {
      "uuid": "3e0e4af9-71ff-4541-b206-6133574bbbc7",
      "created_at": "2023-12-08T22:17:33.185756Z",
      "updated_at": "0001-01-01T00:00:00Z",
      "role": "human",
      "content": "Who were her contemporaries?",
      "metadata": {
        "system": {
          "entities": [],
          "intent": "The subject is requesting information about the people who were living at the same time as the woman in question."
        }
      }
    }
    ```

## Getting all Messages from a Session

=== ":fontawesome-brands-python: Python"

    ```python title="Get all Messages from a Session"
    async with ZepClient(base_url, api_key) as client:
        try:
            messages = await client.message.aget_session_messages(session_id)
            for message in messages:
                print(message.to_dict())
        except NotFoundError:
            print("Sesssion not found")
    ```
    ```json title="Output"
    {
      "messages": [
        {
          "uuid": "3e0e4af9-71ff-4541-b206-6133574bbbc7",
          "created_at": "2023-12-08T22:17:33.185756Z",
          "updated_at": "0001-01-01T00:00:00Z",
          "role": "human",
          "content": "Who were her contemporaries?",
          "metadata": {
            "system": {
              "entities": [],
              "intent": "The subject is requesting information about the people who were living at the same time as the woman in question."
            }
          },
          "token_count": 0
        }
      ],
      ...
    }
    ```

=== ":simple-typescript: TypeScript"

    ```javascript title="Get all Messages from a Session"

    try {
        const sessionID = "3e0e4af9-71ff-4541-b206-6133574bbbc6";  // Replace with the actual session ID
        const messagesForSession = await zepClient.message.getSessionMessages(sessionID);

        messagesForSession.messages.forEach((message) => {
            console.debug(JSON.stringify(message));
        });
    } catch (error) {
        console.error("An error occurred:", error);
    }
    ```
    ```json title="Output"
    {
      "messages": [
        {
          "uuid": "3e0e4af9-71ff-4541-b206-6133574bbbc7",
          "created_at": "2023-12-08T22:17:33.185756Z",
          "updated_at": "0001-01-01T00:00:00Z",
          "role": "human",
          "content": "Who were her contemporaries?",
          "metadata": {
            "system": {
              "entities": [],
              "intent": "The subject is requesting information about the people who were living at the same time as the woman in question."
            }
          },
          "token_count": 0
        }
      ],
      ...
    }
    ```

## Update Session Message Metadata

Below are examples on how to update the metadata on a message.
Currently, updating message content is not supported. You may, however, update a message's metadata.
The metadata should be provided in the following format:

```json title="metadata"
{
  "metadata": {
    "foo": "bar"
  }
}
```

=== ":fontawesome-brands-python: Python"

    ```python title="Update Metadata on a Message"
    async with ZepClient(base_url, api_key) as client:
        try:
            session_id = "3e0e4af9-71ff-4541-b206-6133574bbbc6" # Replace with the actual session_id
            message_uuid = "3e0e4af9-71ff-4541-b206-6133574bbbc7"  # Replace with the actual message_id
            metadata = {
                "metadata": {
                    "foo": "bar"
                }
            }
            await client.message.update_session_message_metadata(session_id, message_id, metadata)
        except NotFoundError:
            print("Session not found")
    ```
    ```json title="Output"
    {
      "uuid": "3e0e4af9-71ff-4541-b206-6133574bbbc7",
      "created_at": "2023-12-08T22:17:33.185756Z",
      "updated_at": "0001-01-01T00:00:00Z",
      "role": "human",
      "content": "Who were her contemporaries?",
      "metadata": {
        "foo": "bar",
        "system": {
          "entities": [],
          "intent": "The subject is requesting information about the people who were living at the same time as the woman in question."
        }
      }
    }
    ```

=== ":simple-typescript: TypeScript"

    ```javascript title="Update Metadata on a Message"
    const sessionID = "3e0e4af9-71ff-4541-b206-6133574bbbc6";  // Replace with the actual session ID
    const messageID = "3e0e4af9-71ff-4541-b206-6133574bbbc7";  // Replace with the actual message ID
    const metadataUpdate = {
        "metadata": {
            "foo": "bar"
        }
    };

    try {
        const messagesForSession = await zepClient.message.updateSessionMessageMetadata(sessionID, messageID, metadataUpdate);
        console.debug(JSON.stringify(message))
    } catch (error) {
        console.error("An error occurred:", error);
    }
    ```
    ```json title="Output"
    {
      "uuid": "3e0e4af9-71ff-4541-b206-6133574bbbc7",
      "created_at": "2023-12-08T22:17:33.185756Z",
      "updated_at": "0001-01-01T00:00:00Z",
      "role": "human",
      "content": "Who were her contemporaries?",
      "metadata": {
        "foo": "bar",
        "system": {
          "entities": [],
          "intent": "The subject is requesting information about the people who were living at the same time as the woman in question."
        }
      }
    }
    ```
