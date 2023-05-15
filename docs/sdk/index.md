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

## Next Steps
- Adding a Memory
- Getting a Session's Memory
- Searching for Memories
- Exploring Auto-Summarization, Token Counts, and Zep Enrichment
