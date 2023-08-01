# Developing with Zep

## Installation

Zep offers both [Python](https://github.com/getzep/zep-python) and [Javascript](https://github.com/getzep/zep-js) SDKs.

Python SDK documentation can be [found here](https://getzep.github.io/zep-python/zep_client/) and Typescript/Javascript documentation can be [found here](https://getzep.github.io/zep-js/)

=== "Python"

    ``` bash
    pip install zep-python

    # or

    poetry add zep-python
    ```

=== "Javascript"

    ``` bash
    npm install @getzep/zep-js

    # or

    yarn add @getzep/zep-js
    ```

!!! note "Running the Zep Server"

    The Zep SDKs require a running Zep server. See the [Quickstart Guide](deployment/quickstart) for more information.

## Initializing the Client

!!! note "Zep supports optional JWT authentication."
    
        The examples below assume that you have enabled JWT authentication.
        See the [Authentication Configuration Guide](/deployment/auth) for more information.

=== "Python"

    ```python
    from zep_python import ZepClient

    # Replace with Zep API URL and (optionally) API key
    zep = ZepClient("http://localhost:8000", api_key="optional_api_key") 
    ```

=== "Javascript"

    ```javascript
    import { ZepClient } from "zep-js";

    // Replace with Zep API URL and (optionally) API key
    const zep = new ZepClient("http://localhost:8000", "optional_api_key"); 
    ```

## Next Steps

Now that you have a Zep client, you can start using the Zep APIs:

### Documents

:octicons-tag-24: **1.9.0pre**

Zep's document vector store is exposed via the [`documents` API](/sdk/documents). With Zep's document vector store, you can build 
collections of documents useful for grounding your prompts. Run semantic search over a collection using either Zep's 
own SDKs, or with Langchain.

[Document API :material-file-document:](/sdk/documents){ .md-button .md-button--primary } 

### Chat History
Zep's chat history store is exposed via the [`chat_history` API](/sdk/chat_history). With Zep's chat history store, you can
capture your app's chat history, enrich it with metadata, and run semantic search over it. Ground your prompts with 
context from prior conversations, both recent and distant past. Use Zep's own SDKs, or with Langchain.

[Chat History API :material-chat:](/sdk/chat_history){ .md-button .md-button--primary }


