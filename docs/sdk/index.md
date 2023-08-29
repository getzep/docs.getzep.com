# Developing with Zep

## Installation

Zep offers both [Python](https://github.com/getzep/zep-python) and [JavaScript](https://github.com/getzep/zep-js) SDKs.

=== ":fontawesome-brands-python: Python"

    ``` bash
    pip install zep-python
    ```

=== ":simple-typescript: TypeScript/JavaScript"

    ``` bash
    npm install @getzep/zep-js

    # or

    yarn add @getzep/zep-js
    ```

## Initializing the Client

!!! note "Zep supports optional JWT authentication."

        The examples below assume that you have enabled JWT authentication.
        See the [Authentication Configuration Guide](../deployment/auth.md) for more information.

=== ":fontawesome-brands-python: Python"

    ```python
    from zep_python import ZepClient

    # Replace with Zep API URL and (optionally) API key
    zep = ZepClient("http://localhost:8000", api_key="optional_api_key")
    ```

=== ":simple-typescript: TypeScript/JavaScript"

    ```javascript
    import { ZepClient } from "zep-js";

    // Replace with Zep API URL and (optionally) API key
    const zep = ZepClient.init("http://localhost:8000", "optional_api_key");
    ```

## Next Steps

[Key Concepts](concepts.md) &nbsp; | &nbsp; [Example Code](examples.md) &nbsp; | &nbsp; [Python API](https://getzep.github.io/zep-python/zep_client/) &nbsp; | &nbsp; [TypeScript/JS API](https://getzep.github.io/zep-js/)

Now that you have a Zep client, you can start using the Zep APIs:

### Documents

Zep's document vector store is exposed via the [`documents` API](documents.md). With Zep's document vector store, you can build
collections of documents useful for grounding your prompts. Run semantic search over a collection using either Zep's
own SDKs, or with Langchain.

[Document API :material-file-document:](documents.md){ .md-button .md-button--primary }

### Chat History

Zep's chat history store is exposed via the [`chat_history` API](chat_history.md). With Zep's chat history store, you can
capture your app's chat history, enrich it with metadata, and run semantic search over it. Ground your prompts with
context from prior conversations, both recent and distant past. Use Zep's own SDKs, or with Langchain.

[Chat History API :material-chat:](chat_history.md){ .md-button .md-button--primary }
