# Developing with Zep

[Example Code](examples.md) &nbsp; | &nbsp; [Python API](https://getzep.github.io/zep-python/) &nbsp; | &nbsp; [TypeScript API](https://getzep.github.io/zep-js/)

## Installation

Zep offers both [Python](https://github.com/getzep/zep-python) and [TypeScript](https://github.com/getzep/zep-js) SDKs.

=== ":fontawesome-brands-python: Python"

    ``` bash
    pip install zep-python
    ```

=== ":simple-typescript: TypeScript"

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

=== ":simple-typescript: TypeScript"

    ```javascript
    import { ZepClient } from "@getzep/zep-js";

    // Replace with Zep API URL and (optionally) API key
    const zep = ZepClient.init("http://localhost:8000", "optional_api_key");
    ```

!!! info "`zep-python` supports async use"

        `zep-python` supports async use. All methods are available as both sync and async, with the async methods
        prefixed with `a`. For example, `zep-python` has both `zep_client.memory.add_memory` 
        and `zep_client.memory.aadd_memory` methods.


## Next Steps

Now that you have a Zep client, you can start using the Zep APIs.

<div class="grid cards" markdown>

-   :material-magnify:{ .lg .middle } __Working with Documents__

    ---

    Populate your prompts with relevant [documents using similarity search](documents.md)


-   :material-chat-outline:{ .lg .middle } __Working with Chat History__

    ---

    Store [Chat History](chat_history/index.md), enrich it with metadata, and run semantic search over it

-   :octicons-rocket-16:{ .lg .middle } __Enrich it all__

    ---

    Learn about [Zep's Extractors](extractors.md) that generate [embeddings](../deployment/embeddings.md), summaries, named entities, token counts, and more.


-   :black_heart:{ .lg .middle } __Use the tools you love__

    ---

    Working with [LangChain 🦜⛓️](langchain.md) and [LlamaIndex 🦙](llamaindex.md)

</div>