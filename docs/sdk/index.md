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

## Next Steps

- Adding a Memory
- Getting a Session's Memory
- Searching for Memories
- Exploring Auto-Summarization, Token Counts, and Zep Enrichment
